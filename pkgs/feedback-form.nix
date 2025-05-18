{buildGoModule, fetchFromGitHub, ...}: 

buildGoModule rec {
	pname = "feedback-form";
	version = "1.1.3";

	src = fetchFromGitHub {
	  owner = "roemu";
	  repo = "feedback-form";
	  rev = "v${version}";
	  hash = "sha256-9vhOEforFnU2AaQ62NY+4qdcKdmB5XekcaSyMw1laZI=";
	};
	
	vendorHash = "sha256-EbxLmOtSweB/81GDLtzYLH9nrMVjWp5d72Wqws926us=";

	env.CGO_ENABLED = 1;

	meta = {
		description = "simple feedback form";
		homepage = "https://github.com/roemu/feedback-form";
	};
}
