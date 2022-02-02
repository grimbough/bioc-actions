BIOC=$1

case ${BIOC} in
  devel)
    echo '4.2'
    ;;
  3.15)
    echo '4.2'
    ;;
  3.14)
    echo '4.1'
    ;;
  *)
    echo "UNKNOWN"
    ;;
esac
