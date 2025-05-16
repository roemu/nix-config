{pkgs, ...}: {
  environment.systemPackages = [pkgs.feedback-form];
  systemd.services.feedback-form = {
    enable = true;
    description = "Ssh app for feedback form";
    after = ["network.target"];

    serviceConfig = {
      ExecStart = "${pkgs.feedback-form}/bin/feedback-form --port 22 --db-path=/home/roemu/data/feedbacks.db";
    };
    wantedBy = ["multi-user.target"];
  };
}
