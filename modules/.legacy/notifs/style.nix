{ config, lib, ... }:

with config.lib.stylix.colors;
{
  services.swaync.style = lib.mkForce ''
    @define-color base00 #${base00}; @define-color base01 #${base01}; @define-color base02 #${base02}; @define-color base03 #${base03};
    @define-color base04 #${base04}; @define-color base05 #${base05}; @define-color base06 #${base06}; @define-color base07 #${base07};

    @define-color base08 #${base08}; @define-color base09 #${base09}; @define-color base0A #${base0A}; @define-color base0B #${base0B};
    @define-color base0C #${base0C}; @define-color base0D #${base0D}; @define-color base0E #${base0E}; @define-color base0F #${base0F};

* {
  font-family: "Inconsolata Nerd Font Propo";
  transition: all 0.3s ease;
}
.notification-row {
  outline: none;
}

.notification-row:focus, .notification-row:hover {
  background: @noti-bg-focus;
}

.notification-row .notification-background {
  padding: 6px 12px;
}

.notification-row .notification-background .close-button {
  /* The notification Close Button */
  background: @base03;
  color: @base00;
  text-shadow: none;
  padding: 0;
  border-radius: 100%;
  margin-top: 5px;
  margin-right: 5px;
  box-shadow: none;
  border: none;
  min-width: 24px;
  min-height: 24px;
}

.notification-row .notification-background .close-button:hover {
  box-shadow: none;
  background: @base08;
  transition: background 0.15s ease-in-out;
  border: none;
}

.notification-row .notification-background .notification {
  /* The actual notification */
  border-radius: 0.475rem;
  /*border: 1px solid @noti-border-color;*/
  border: 1px solid @base01;
  padding: 0;
  transition: background 0.15s ease-in-out;
  background: @base01;
}

.notification-row .notification-background .notification.low {
  /* Low Priority Notification */
}

.notification-row .notification-background .notification.normal {
  /* Normal Priority Notification */
}

.notification-row .notification-background .notification.critical {
  /* Critical Priority Notification */
}

.notification-row .notification-background .notification .notification-action, .notification-row .notification-background .notification .notification-default-action {
  padding: 4px;
  margin: 0;
  box-shadow: none;
  background: transparent;
  border: none;
  color: @base05;
  transition: background 0.15s ease-in-out;
}

.notification-row .notification-background .notification .notification-action:hover, .notification-row .notification-background .notification .notification-default-action:hover {
  -gtk-icon-effect: none;
  background: @base02;
}

.notification-row .notification-background .notification .notification-default-action {
  /* The large action that also displays the notification summary and body */
  border-radius: 0.475rem;
}

.notification-row .notification-background .notification .notification-default-action:not(:only-child) {
  /* When alternative actions are visible */
  border-bottom-left-radius: 0px;
  border-bottom-right-radius: 0px;
}

.notification-row .notification-background .notification .notification-default-action .notification-content {
  background: transparent;
  border-radius: 0.475rem;
  /* Padding between the notification text and the notification itself */
  padding: 16px;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .image {
  /* Notification Primary Image */
  -gtk-icon-effect: none;
  border-radius: 0;
  /* Size in px */
  margin: 0 8px 0 0;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .app-icon {
  /* Notification app icon (only visible when the primary image is set) */
  -gtk-icon-effect: none;
  -gtk-icon-shadow: 0 1px 4px black;
  margin: 6px;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .text-box .summary {
  /* Notification summary/title */
  font-size: 16px;
  font-weight: bold;
  background: transparent;
  color: @base05;
  text-shadow: none;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .text-box .time {
  /* Notification time-ago */
  font-size: 12px;
  font-weight: bold;
  background: transparent;
  color: @base03;
  text-shadow: none;
  margin-right: 30px;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .text-box .body {
  /* Notification body */
  font-size: 15px;
  font-weight: normal;
  background: transparent;
  color: @base05;
  text-shadow: none;
}

.notification-row .notification-background .notification .notification-default-action .notification-content progressbar {
  /* The optional notification progress bar */
  margin-top: 4px;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .body-image {
  /* The "extra" optional bottom notification image */
  margin-top: 4px;
  background-color: white;
  border-radius: 1rem;
  -gtk-icon-effect: none;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply {
  /* The inline reply section */
  margin-top: 4px;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply .inline-reply-entry {
  background: @noti-bg-darker;
  color: @text-color;
  caret-color: @text-color;
  border: 1px solid @noti-border-color;
  border-radius: 0.475rem;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply .inline-reply-button {
  margin-left: 4px;
  background: @noti-bg;
  border: 1px solid @noti-border-color;
  border-radius: 0.475rem;
  color: @text-color;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply .inline-reply-button:disabled {
  background: initial;
  color: @text-color-disabled;
  border: 1px solid @noti-border-color;
  border-color: transparent;
}

.notification-row .notification-background .notification .notification-default-action .notification-content .inline-reply .inline-reply-button:hover {
  background: @noti-bg-hover;
}

.notification-row .notification-background .notification .notification-action {
  /* The alternative actions below the default action */
  border-top: 1px solid @noti-border-color;
  border-radius: 0px;
  border-right: 1px solid @noti-border-color;
}

.notification-row .notification-background .notification .notification-action:first-child {
  /* add bottom border radius to eliminate clipping */
  border-bottom-left-radius: 12px;
}

.notification-row .notification-background .notification .notification-action:last-child {
  border-bottom-right-radius: 12px;
  border-right: none;
}

.notification-group {
  /* Styling only for Grouped Notifications */
}

.notification-group.low {
  /* Low Priority Group */
}

.notification-group.normal {
  /* Low Priority Group */
}

.notification-group.critical {
  /* Low Priority Group */
}

.notification-group .notification-group-buttons, .notification-group .notification-group-headers {
  margin: 0 16px;
  color: @base05;
}

.notification-group .notification-group-headers {
  /* Notification Group Headers */
}

.notification-group .notification-group-headers .notification-group-icon {
  color: @base05;
}

.notification-group .notification-group-headers .notification-group-header {
  color: @base05;
}

.notification-group .notification-group-buttons {
  /* Notification Group Buttons */
  padding: 10px;
}

.notification-group.collapsed .notification-row .notification {
  background-color: @base00;
}

.notification-group.collapsed .notification-row:not(:last-child) {
  /* Top notification in stack */
  /* Set lower stacked notifications opacity to 0 */
}

.notification-group.collapsed .notification-row:not(:last-child) .notification-action,
.notification-group.collapsed .notification-row:not(:last-child) .notification-default-action {
  opacity: 0;
}

.notification-group.collapsed:hover .notification-row:not(:only-child) .notification {
  background-color: @base01;
}

.control-center {
  /* The Control Center which contains the old notifications + widgets */
  background: alpha(@base01, ${toString config.stylix.opacity.desktop});
  color: @base05;
  border-radius: 0.475rem;
}

.control-center .control-center-list-placeholder {
  /* The placeholder when there are no notifications */
  opacity: 0.5;
}

.control-center .control-center-list {
  /* List of notifications */
  background: transparent;
}

.control-center .control-center-list .notification {
  /* The notifications in the list */
  box-shadow: 0px 0px 5px 0px rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-r}, 0.1);
  padding: 2px;
  margin: 0;
}
.control-center .control-center-list .close-button {
  margin: 8px;
}

.control-center .control-center-list .notification .notification-default-action,
.control-center .control-center-list .notification .notification-action {
  transition: opacity 400ms ease-in-out, background 0.15s ease-in-out;
}

.blank-window {
  /* Window behind control center and on all other monitors */
  background: transparent;
}

.floating-notifications {
  background: transparent;
}

.floating-notifications .notification {
  box-shadow: none;
}

/*** Widgets ***/
/* Title widget */
.widget-title {
  color: @base05;
  font-weight: bold;
  margin: 16px 20px 8px 20px;
  font-size: 1.5rem;
}

.widget-title > button {
  font-size: initial;
  color: @text-color;
  text-shadow: none;
  background: @noti-bg;
  border: 1px solid @noti-border-color;
  box-shadow: none;
  border-radius: 1rem;
}

.widget-title > button:hover {
  background: @noti-bg-hover;
}

/* Label widget */
.widget-label {
  margin: 8px;
}

.widget-label > label {
  font-size: 1.1rem;
}

/* Mpris widget */
@define-color mpris-album-art-overlay rgba(0, 0, 0, 0.55);
@define-color mpris-button-hover rgba(0, 0, 0, 0.50);
.widget-mpris {
  /* The parent to all players */
  box-shadow: none;
}

.widget-mpris .widget-mpris-player {
  padding: 16px;
  margin: 16px;
  background-color: @mpris-album-art-overlay;
  border-radius: 0.475rem;
  box-shadow: 0px 0px 5px 0px rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-r}, 0.7);
  color: @base05;
}

.widget-mpris .widget-mpris-player button:hover {
  /* The media player buttons (play, pause, next, etc...) */
  background: @noti-bg-hover;
}

.widget-mpris .widget-mpris-player .widget-mpris-album-art {
  border-radius: 0.625rem;
  box-shadow: 0px 0px 5px 0px rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-r}, 0.7);
}

.widget-mpris .widget-mpris-player .widget-mpris-title {
  font-weight: bold;
  font-size: 1.25rem;
}

.widget-mpris .widget-mpris-player .widget-mpris-subtitle {
  font-size: 1.1rem;
}

.widget-mpris .widget-mpris-player > box > button {
  /* Change player control buttons */
  padding: 2px;
  border-radius: 0.475rem;
  color: @base05;
}

.widget-mpris .widget-mpris-player > box > button:hover {
  background-color: alpha(@base02, 0.5);
}

.widget-mpris > box > button {
  /* Change player side buttons */
  margin: 48px -24px;
  padding: 5px;
  border-radius: 0.475rem;
  color: @base05;
}

.widget-mpris > box > button:hover {
  margin: 36px -12px;
  padding: 15px;
  background-color: @base02;
  color: @base05;
  box-shadow: 0px 0px 5px 0px rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-r}, 0.1);
}

.widget-mpris > box > button:disabled {
  /* Change player side buttons insensitive */
}

/* Buttons widget */
.widget-buttons-grid {
  padding: 8px;
  margin: 0 6px;
  background-color: transparent;
}

.widget-buttons-grid > flowbox > flowboxchild > button {
  background: @base01;
  border-radius: 0.475rem;
  padding: 5px 0;
  margin: 0px;
  color: @base05;
  box-shadow: 0px 0px 4px 0px rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-r}, 0.1);
}

.widget-buttons-grid > flowbox > flowboxchild > button:hover {
  /* style given to the active toggle button */
  background: @base02;
}

.widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked {
  /* style given to the active toggle button */
  /* background: linear-gradient(to right, @base0F, @base04); */
  background: @base0E;
  color: @base00;
}

  '';
}
