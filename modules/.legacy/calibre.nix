{ ... }:

{
  services.calibre-web = {
    enable = true;
    listen.ip = "0.0.0.0";
    listen.port = 8083;
    options = {
      calibreLibrary = "/mnt/zichi/media/library/"; # Must have a metadata.db file in directory for calibre to work, sample file can be downloaded at https://github.com/janeczku/calibre-web/raw/master/library/metadata.db
      enableBookUploading = true;
    };
    openFirewall = true;
  };
}
