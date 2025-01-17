{ lib, stdenv, fetchurl, libgpg-error, libassuan, libgcrypt, pkcs11helper,
  pkg-config, openssl }:

stdenv.mkDerivation rec {
  pname = "gnupg-pkcs11-scd";
  version = "0.9.2";

  src = fetchurl {
    url = "https://github.com/alonbl/${pname}/releases/download/${pname}-${version}/${pname}-${version}.tar.bz2";
    sha256 = "1mfh9zjbahjd788rq1mzx009pd7p1sq62sbz586rd7szif7pkpgx";
  };

  buildInputs = [ pkcs11helper pkg-config openssl ];

  configureFlags = [
    "--with-libgpg-error-prefix=${libgpg-error.dev}"
    "--with-libassuan-prefix=${libassuan.dev}"
    "--with-libgcrypt-prefix=${libgcrypt.dev}"
  ];

  meta = with lib; {
    description = "A smart-card daemon to enable the use of PKCS#11 tokens with GnuPG";
    longDescription = ''
    gnupg-pkcs11 is a project to implement a BSD-licensed smart-card
    daemon to enable the use of PKCS#11 tokens with GnuPG.
    '';
    homepage = "http://gnupg-pkcs11.sourceforge.net/";
    license = licenses.bsd3;
    maintainers = with maintainers; [ matthiasbeyer philandstuff ];
    platforms = platforms.unix;
  };
}

