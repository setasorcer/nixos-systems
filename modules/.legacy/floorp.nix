{ config, ... }:

{
  programs.floorp = {
    enable = false;
    policies = {
      BlockAboutConfig = true;
      DefaultDownloadDirectory = "${config.home.homeDirectory}/";
    };
    profiles."default" = {
      containers = {
        "Personal" = {
	  color = "blue";
	  icon = "fingerprint";
	  id = 1;
	};
	"School" = {
	  color = "red";
	  icon = "fruit";
	  id = 2;
	};
	"Business" = {
	  color = "green";
	  icon = "dollar";
	  id = 3;
	};
      };
      containersForce = true;
      settings = {
        "media.hardware-video-decoding.force-enabled" = true;
	"dom.security.https_only_mode_send_http_background_request" = false;
      };
    };
  };
}
