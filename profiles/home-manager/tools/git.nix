{inputs, ...}: c: {...}: {
  # git
  programs.git = {
    enable = true;
    userName = c.userName;
    userEmail = c.userEmail;
  };
  programs.git.delta = {
    enable = true;
  };
  programs.gh = {
    enable = true;
  };
}
