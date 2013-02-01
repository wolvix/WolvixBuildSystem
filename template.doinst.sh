#===============================================================================
# doinst.sh stuff - use/adapt as needed
#===============================================================================

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# Keep same perms on rc.INIT.new:
if [ -e etc/rc.d/rc.INIT ]; then
  cp -a etc/rc.d/rc.INIT etc/rc.d/rc.INIT.new.incoming
  cat etc/rc.d/rc.INIT.new > etc/rc.d/rc.INIT.new.incoming
  mv etc/rc.d/rc.INIT.new.incoming etc/rc.d/rc.INIT.new
fi

config etc/rc.d/rc.INIT.new
config etc/configfile.new
