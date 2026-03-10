# This is an example PKGBUILD file. Use this as a start to creating your own,
# and remove these comments. For more information, see 'man PKGBUILD'.
# NOTE: Please fill out the license field for your package! If it is unknown,
# then please put 'unknown'.

# Maintainer: Zaki Sangam <sangamzaki@gmail.com>
pkgname='Dots-0_0'
pkgver=1
pkgrel=1
pkgdesc="My custom rice"
arch=('x86_64')
url="https://github.com/Lazydev0/Dots-0_0"
license=('GPL')
depends=()
makedepends=()
backup=()
install=
source=('${pkgname}::git://github.com/Lazydev0/${pkgname}')
sha256sums=('SKIP')

pkgver() {

}

build() {
  cd "$pkgname-$pkgver"
  ./configure --prefix=/usr
  make
}

package() {
  cd "$pkgname-$pkgver"
  make DESTDIR="$pkgdir/" install
}
