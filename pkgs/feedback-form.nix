{buildGoModule, fetchFromGitHub, ...}: 

buildGoModule rec {
	pname = "feedback-form";
	version = "1.1.0";

	src = fetchFromGitHub {
	  owner = "roemu";
	  repo = "feedback-form";
	  rev = "v${version}";
	  hash = "sha256-WmPASCu2YGD+uCTRXPjXaxMIwWWo0q/IggL0nj+Erb4=";
	};
	
	vendorHash = "sha256-EbxLmOtSweB/81GDLtzYLH9nrMVjWp5d72Wqws926us=";

	env.CGO_ENABLED = 1;

	meta = {
		description = "simple feedback form";
		homepage = "https://github.com/roemu/feedback-form";
	};
}
