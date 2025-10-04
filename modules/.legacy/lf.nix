{ config, lib, pkgs, ... }:

{
  # lf accessories
  home.packages = with pkgs; [
    xdragon # Dragon deez nuts
    moreutils # vidir
    chafa # Sixel companion
    ouch # archives

    # Companion script for sixel graphics
    (writeShellScriptBin "lfub" ''
      set -e

      if [ -n "$SSH_CLIENT"] || [ -n "$SSH_TTY" ]; then
        lf "$@"
      else
        [ ! -d "$HOME/.cache/lf" ] && mkdir --parents "$HOME/.cache/lf"
	lf "$@" 3>&-
      fi
    '')
  ];
  programs.bat.enable = true; # Prettier cat
  programs.lf = {
    enable = true;
    settings = {
      ifs = ''\n'';
      period = 10;
      dircounts = true;
      info = "size";
      sixel = true;
      autoquit = true;
    };
    # filesep helps with xdragon
    extraConfig = ''
      set shellopts '-eu'
      set filesep '" "'
    '';
    commands = {
      extract = ''''${{
        set -f
	ouch decompress "$fx"
      }}'';
      # FUCKING FINALLY
      drag-and-drop = ''''${{
        set -f
	sh -c "dragon -a $(echo \"$fx\")"
      }}'';

      #open = "$xdg-open \"$f\"";
      bulkrename = "$vidir";
    };
    keybindings = {
      gh = null;
      g = "top";
      D = "delete";
      E = "extract";
      "<c-n>" = "push %mkdir<space>";
      "<c-r>" = "reload";
      "<c-s>" = "set hidden!";
      "<enter>" = "shell";

      "]" = "push hkl";
      "[" = "push hjl";

      A = "rename"; # very end
      c = "push A<c-u>"; # new
      I = "push A<c-a>"; # very beginning
      i = "push A<a-b><a-b><a-f>"; # before extension
      a = "push A<a-b>"; # after extension
      B = "bulkrename";

      U = "clear";

      "<c-e>" = "down";
      "<c-y>" = "up";
      V = "$nvim $f";

      W = "$setsid -f $TERMINAL >/dev/null 2>&1";

      "<insert>" = "push $touch<space>";
      "<c-t>" = "drag-and-drop";
    };
    previewer.source = pkgs.writeShellScript "pv.sh" ''
      #!/usr/bin/env bash
      
      image() {
      	geometry="$(($2-2))x$3"
      	chafa -f sixel "$1" -s "$geometry" --animate false
      }
      
      batorcat() {
      	file="$1"
      	shift
      	if command -v bat > /dev/null 2>&1
      	then
      		bat --color=always --style=plain --pager=never "$file" "$@"
      	else
      		cat "$file"
      	fi
      }
      
      glowormdcat() {
      	file="$1"
      	shift
      	if command -v glow > /dev/null 2>&1
      	then
      		glow "$file"
      	else
      		mdcat "$file"
      	fi
      }
      
      CACHE="$HOME/.cache/lf/thumbnail.$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}'))"
      
      case "$(printf "%s\n" "$(readlink -f "$1")" | awk '{print tolower($0)}')" in
      	*.tgz|*.tar.gz) ouch l "$1" ;;
      	*.tar.bz2|*.tbz2) ouch l "$1" ;;
      	*.tar.txz|*.txz) ouch l "$1" ;;
      	*.tar) ouch l "$1" ;;
      	*.zip|*.jar|*.war|*.ear|*.oxt) ouch l "$1" ;;
      	*.rar) ouch l "$1" ;;
        *.md) 
        	glowormdcat "$1";;
      	*.7z) ouch l "$1" ;;
      	*.[1-8]) man "$1" | col -b ;;
      	*.o) nm "$1";;
      	*.torrent) transmission-show "$1" ;;
      	*.iso) iso-info --no-header -l "$1" ;;
      	*.odt|*.ods|*.odp|*.sxw) odt2txt "$1" ;;
      	*.doc) catdoc "$1" ;;
      	*.docx) docx2txt "$1" ;;
        *.xml|*.html) w3m -dump "$1";;
      	*.xls|*.xlsx)
      		ssconvert --export-type=Gnumeric_stf:stf_csv "$1" "fd://1" | batorcat --language=csv
      		;;
      	*.wav|*.mp3|*.flac|*.m4a|*.wma|*.ape|*.ac3|*.og[agx]|*.spx|*.opus|*.as[fx]|*.mka)
      		exiftool "$1"
      		;;
      	*.pdf)
      		[ ! -f "''${CACHE}.jpg" ] && \
      			${pkgs.poppler_utils}/bin/pdftoppm -jpeg -f 1 -singlefile "$1" "$CACHE"
      		image "''${CACHE}.jpg" "$2" "$3" "$4" "$5"
      		;;
      	*.epub)
      		[ ! -f "$CACHE" ] && \
      			epub-thumbnailer "$1" "$CACHE" 1024
      		image "$CACHE" "$2" "$3" "$4" "$5"
      		;;
      	*.cbz|*.cbr|*.cbt)
      		[ ! -f "$CACHE" ] && \
      			comicthumb "$1" "$CACHE" 1024
      		image "$CACHE" "$2" "$3" "$4" "$5"
      		;;
      	*.avi|*.mp4|*.wmv|*.dat|*.3gp|*.ogv|*.mkv|*.mpg|*.mpeg|*.vob|*.fl[icv]|*.m2v|*.mov|*.webm|*.ts|*.mts|*.m4v|*.r[am]|*.qt|*.divx)
      		[ ! -f "''${CACHE}.jpg" ] && \
      			${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$1" -o "''${CACHE}.jpg" -s 0 -q 5
      		image "''${CACHE}.jpg" "$2" "$3" "$4" "$5"
      		;;
      	*.bmp|*.jpg|*.jpeg|*.png|*.xpm|*.webp|*.tiff|*.gif|*.jfif|*.ico)
      		image "$1" "$2" "$3" "$4" "$5"
      		;;
        *.svg)
          [ ! -f "''${CACHE}.jpg" ] && \
            convert "$1" "''${CACHE}.jpg"
          image "''${CACHE}.jpg" "$2" "$3" "$4" "$5"
          ;;
      	*.ino)
      		batorcat --language=cpp "$1"
      		;;
      	*)
      		batorcat "$1"
      		;;
      esac
      exit 0
    '';
  };
}
