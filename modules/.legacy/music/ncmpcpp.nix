{ config, pkgs, ... }:

let
  notify-mpd = pkgs.writeShellScript "notify-mpd.sh" ''
    music_dir=${config.services.mpd.musicDirectory}
    current_file=$(mpc current -f "%file%")
    current_dir=$(dirname "$current_file")

    if [[ -n "$current_file" ]]; then
      # Try finding artwork in the album directory
      filename=$(find "$music_dir"/"$current_dir" -iregex '^.*\(front\|cover\|folder\)\.\(jpg\|png\|bmp\)$' | head -1)
      # Otherwise, try to extract artwork from the music file
      if [[ -z "$filename" ]]; then
        tmpimgfile=$(mktemp --suffix=.jpg)
        ffmpeg -hide_banner -loglevel error -i "$music_dir"/"$current_file" "$tmpimgfile" -y
        if ! cmp -s "$filename" "$tmpimgfile"; then
          filename=$tmpimgfile
        fi

        find /tmp 2>/dev/null -name "tmp.*.jpg" | grep -v "$filename"| xargs -r rm
      fi

      # Finally, if no art can be found then fallback to a placeholder image
      if [[ -z "$filename" ]]  || [[ ! -s "$filename" ]]; then
        filename="$HOME/Pictures/no_art.png"
      fi
    fi

    notify-send -e -u low -h string:synchronous:current-song "$(mpc current -f %title%)" "$(mpc current -f %artist%)" -i "$filename"
  '';
in
{
  programs.inori = {
    enable = true;
    settings = {
      qwerty_keybindings = true;
    };
  };
  programs.ncmpcpp = {
    enable = true;
    bindings = [
      { key = "j"; command = "scroll_down"; }
      { key = "k"; command = "scroll_up"; }
      { key = "J"; command = [ "select_item" "scroll_down" ]; }
      { key = "K"; command = [ "select_item" "scroll_up" ]; }
      { key = "h"; command = "previous_column"; }
      { key = "l"; command = "next_column"; }
      { key = "ctrl-b"; command = "page_up"; }
      { key = "ctrl-u"; command = "page_up"; }
      { key = "ctrl-f"; command = "page_down"; }
      { key = "ctrl-d"; command = "page_down"; }
      { key = "g"; command = "move_home"; }
      { key = "G"; command = "move_end"; }
      { key = "n"; command = "next_found_item"; }
      { key = "N"; command = "previous_found_item"; }
      { key = "."; command = "show_lyrics"; }
      { key = "/"; command = "find"; }
      { key = "/"; command = "find_item_forward"; }
      { key = "+"; command = "show_clock"; }
    ];
    settings = {
      lyrics_directory = "${config.services.mpd.musicDirectory}/rslyrics";
      # Notify new songs
      execute_on_song_change = "${notify-mpd}";

      startup_screen = "media_library";
      # Playlist formatting
      song_list_format = "$3{%a $8 %t $/r$/u$R$3%l}|{%f$/r}";
      /* Speedy Ortiz  Tiger Tank		2:46 */ 
      now_playing_suffix = "$/b";
      playlist_display_mode = "classic";

      # Progressbar
      progressbar_look = "▃▃ ";
      progressbar_elapsed_color = "green";
      connected_message_on_startup = false;

      song_columns_list_format = "(50)[6]{t} (50)[4]{ar} $b(5f)[9]{lr}$/b";

      # Colours
      header_window_color = "white";
      main_window_color = "green";
      alternative_ui_separator_color = "white";

      # General formatting
      titles_visibility = false;
      header_visibility = false;
      statusbar_visibility = false;
      song_status_format = "{%b}|{%f}";
      alternative_header_first_line_format = "$8$b» {%t} «$/b";
      alternative_header_second_line_format = "$3{%b (%y)}|{/%D/}";
      #display_volume_level = false;
      user_interface = "alternative";
      current_item_prefix = "$(16)$r";
      current_item_suffix = "$/r$(end)";
      # Default sort is album artist
      media_library_primary_tag = "album_artist";

      # Misc
      discard_colors_if_item_is_selected = true;
      autocenter_mode = true;
      mouse_support = false;
      centered_cursor = true;
      colors_enabled = true;
      mpd_crossfade_time = 0;
      follow_now_playing_lyrics = true;
    };
  };
}
