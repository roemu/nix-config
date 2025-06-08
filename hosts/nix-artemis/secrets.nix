{
  age = {
    secrets = {
      password = {
        file = ../../secrets/password.age;
        owner = "roemu";
      };
      tailscale-key = {
        file = ../../secrets/tailscale-key.age;
      };
    };
  };
}
