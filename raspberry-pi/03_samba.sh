sudo -s -- << EOS
# install samba
apt install -y samba

# add default user (SECURITY RISK!)
(echo "raspberry" && echo "raspberry") | smbpasswd -a pi

# write configuration
mv -vn /etc/samba/smb.conf /etc/samba/smb.conf.original
cat > /etc/samba/smb.conf << EOF
workgroup = FRAME FACTORY
server string = Electro Pi 
security = user
map to guest = bad user
unix password sync = yes

[root]
  comment = Electro Pi File System
  path = /
  browseable = yes
  guest ok = no
  read only = no
  create mask = 0664
  directory mask = 0775
EOF

# restart services
service smbd restart
service nmbd restart
EOS
