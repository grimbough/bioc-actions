set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: get-r-version.sh <bioc-version>" >&2
  echo "  <bioc-version> must be 'release', 'devel', or a version number e.g. '3.20'" >&2
  exit 1
fi

BIOC_VERSION="${1,,}"

# Validate format: must be "release", "devel", or a numeric version like "3.xy"
if [[ ! "$BIOC_VERSION" =~ ^(release|devel|[0-9]+\.[0-9]+)$ ]]; then
  echo "Invalid Bioconductor version: '$1'" >&2
  echo "Must be 'release', 'devel', or a version number e.g. '3.20'" >&2
  exit 1
fi

##############################################################################
# Fetch Bioconductor config.yaml (same source used by BiocManager)
##############################################################################
CONFIG_URL="https://bioconductor.org/config.yaml"
CONFIG=$(curl -fsSL --max-time 30 "$CONFIG_URL")

# Extract current release and devel version strings
RELEASE_VERSION=$(echo "$CONFIG" | grep '^release_version:' | sed 's/release_version: *"\(.*\)"/\1/')
DEVEL_VERSION=$(echo "$CONFIG" | grep '^devel_version:' | sed 's/devel_version: *"\(.*\)"/\1/')

# Resolve "release" / "devel" aliases to explicit version numbers
case "$BIOC_VERSION" in
  release) BIOC_EXPLICIT="$RELEASE_VERSION" ;;
  devel)   BIOC_EXPLICIT="$DEVEL_VERSION" ;;
  *)       BIOC_EXPLICIT="$BIOC_VERSION" ;;
esac

# Look up the R version for this Bioc version from the r_ver_for_bioc_ver map
R_VERSION_RAW=$(echo "$CONFIG" | grep "^ *\"${BIOC_EXPLICIT}\":" | sed 's/.*"\([^"]*\)": *"\([^"]*\)".*/\2/' | head -1 || true)

if [ -z "$R_VERSION_RAW" ]; then
  echo "Unknown Bioconductor version: $BIOC_VERSION" >&2
  exit 1
fi

##############################################################################
# For the devel Bioc version, check whether that R version is already
# released, a release candidate ("next"), or still unreleased ("devel").
# r-lib/actions/setup-r accepts "devel" and "next" as special values.
##############################################################################
R_VERSION="$R_VERSION_RAW"
if [ "$BIOC_EXPLICIT" = "$DEVEL_VERSION" ]; then
  CURRENT_R=$(curl -fsSL --max-time 30 "https://api.r-hub.io/rversions/r-release" | sed 's/.*"version":"\([^"]*\)".*/\1/')
  CURRENT_R_MINOR="${CURRENT_R%.*}"   # e.g. "4.6" from "4.6.0"
  if [ "$R_VERSION_RAW" != "$CURRENT_R_MINOR" ]; then
    NEXT_R=$(curl -fsSL --max-time 30 "https://api.r-hub.io/rversions/r-next" | sed 's/.*"version":"\([^"]*\)".*/\1/')
    NEXT_R_MINOR="${NEXT_R%.*}"
    if [ "$R_VERSION_RAW" = "$NEXT_R_MINOR" ]; then
      R_VERSION="next"
    else
      R_VERSION="devel"
    fi
  fi
fi

##############################################################################
# Look up the Rtools version from the r-hub API.
# The API returns entries with "first" and "last" R version boundaries.
# We append ".0" to R_VERSION_RAW (which is major.minor) so it can be
# compared as a three-part version against the boundary strings.
##############################################################################
RTOOLS_DATA=$(curl -fsSL --max-time 30 "https://api.r-hub.io/rversions/rtools-versions")
RTOOLS=$(echo "$RTOOLS_DATA" | jq -r --arg rv "${R_VERSION_RAW}.0" '
  def vparts: split(".") | map(tonumber);
  def vle(a; b):
    (a | vparts) as $a | (b | vparts) as $b |
    if   $a[0] != $b[0] then $a[0] <= $b[0]
    elif $a[1] != $b[1] then $a[1] <= $b[1]
    else $a[2] <= $b[2] end;
  .[] | select(vle(.first; $rv) and vle($rv; .last)) | .version
' | tail -1)

if [ -z "$RTOOLS" ]; then
  echo "Could not determine Rtools version for R ${R_VERSION_RAW}" >&2
  exit 1
fi

##############################################################################
# Output KEY=VALUE pairs for all three requested fields
##############################################################################
echo "r_version=${R_VERSION}"
echo "rtools=${RTOOLS}"
echo "bioc_version_explicit=${BIOC_EXPLICIT}"
exit 0
