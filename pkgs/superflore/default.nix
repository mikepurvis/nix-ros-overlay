{ lib, buildPythonPackage, fetchFromGitHub, xmltodict, termcolor, setuptools
, rosinstall-generator, rosdistro, rosdep, gitpython, requests, docker, pyyaml
, pygithub, catkin-pkg, rospkg
}:

buildPythonPackage rec {
  pname = "superflore";
  version = "0.3.3-unstable-2026-05-05";

  src = fetchFromGitHub {
    owner = "mikepurvis";
    repo = "superflore";
    # ref = "refs/heads/nix-passthru-deps";
    rev = "dd5ef4146f814db14b43ed7ea16ef978d44cac01";
    hash = "sha256-mCKkYthdImKPvgWbcTcQF+yX/lq9nb+ZQDhNFcHaimE=";
    # date = "2026-09-20T19:33:50+02:00";
  };

  pyproject = true;
  build-system = [ setuptools ];

  propagatedBuildInputs = [
    xmltodict
    termcolor
    setuptools
    rosinstall-generator
    rosdistro
    rosdep
    gitpython
    requests
    docker
    pyyaml
    pygithub
    catkin-pkg
    rospkg
  ];

  # Tests require internet
  doCheck = false;

  meta = with lib; {
    description = "Extended release manager for ROS";
    homepage = "https://github.com/ros-infrastructure/superflore";
    license = licenses.asl20;
    maintainers = with maintainers; [ lopsided98 ];
  };
}
