{buildGoModule, fetchFromGitHub, ...}: 

buildGoModule rec {
	pname = "feedback-form";
	version = "1.0.0";

	src = fetchFromGitHub {
	  owner = "roemu";
	  repo = "feedback-form";
	  rev = "v${version}";
	  hash = "sha256-KqJom6x/QsLTFQ3sZ15/6mfvc4OEYJijN6PhgSx5HDE=";
	};
	
	vendorHash = "sha256-EbxLmOtSweB/81GDLtzYLH9nrMVjWp5d72Wqws926us=";

	env.CGO_ENABLED = 1;

	meta = {
		description = "simple feedback form";
		homepage = "https://github.com/roemu/feedback-form";
	};
}
