{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  cmake,
  doxygen,
  boost,
  eigen,
  jrl-cmakemodules,
  numpy,
  scipy,
}:

buildPythonPackage rec {
  pname = "eigenpy";
  version = "3.10.0";
  pyproject = false; # Built with cmake

  src = fetchFromGitHub {
    owner = "stack-of-tasks";
    repo = "eigenpy";
    rev = "refs/tags/v${version}";
    hash = "sha256-ac667pEKXcbLLzCVGKYpyCQO805qhCEf8dCnC4QwxBs=";
  };

  outputs = [
    "dev"
    "doc"
    "out"
  ];

  cmakeFlags = [
    "-DINSTALL_DOCUMENTATION=ON"
    "-DBUILD_TESTING_SCIPY=ON"
  ];

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    doxygen
    scipy
  ];

  buildInputs = [ boost ];

  propagatedBuildInputs = [
    eigen
    jrl-cmakemodules
    numpy
  ];

  pythonImportsCheck = [ "eigenpy" ];

  meta = with lib; {
    description = "Bindings between Numpy and Eigen using Boost.Python";
    homepage = "https://github.com/stack-of-tasks/eigenpy";
    changelog = "https://github.com/stack-of-tasks/eigenpy/releases/tag/v${version}";
    license = licenses.bsd2;
    maintainers = with maintainers; [
      nim65s
      wegank
    ];
    platforms = platforms.unix;
  };
}
