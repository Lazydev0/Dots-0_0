function findAdjacent(hex, gradients, delta) {
  var red = parseInt(hex.substr(0, 2), 16)
  var green = parseInt(hex.substr(2, 2), 16)
  var blue = parseInt(hex.substr(4,2), 16)
  var newHex

  if (red > delta) {
    newHex = ('0' + (red - delta).toString(16)).substr(-2) +
      ('0' + green.toString(16)).substr(-2) +
      ('0' + blue.toString(16)).substr(-2)
    if (gradients[newHex]) {
      return gradients[newHex]
    }
  }

  if (green > delta) {
    newHex = ('0' + red.toString(16)).substr(-2) +
      ('0' + (green - delta).toString(16)).substr(-2) +
      ('0' + blue.toString(16)).substr(-2)
    if (gradients[newHex]) {
      return gradients[newHex]
    }
  }

  if (blue > delta) {
    newHex = ('0' + red.toString(16)).substr(-2) +
      ('0' + green.toString(16)).substr(-2) +
      ('0' + (blue - delta).toString(16)).substr(-2)
    if (gradients[newHex]) {
      return gradients[newHex]
    }
  }

  if (red < 255 - delta) {
    newHex = ('0' + (red + delta).toString(16)).substr(-2) +
      ('0' + green.toString(16)).substr(-2) +
      ('0' + blue.toString(16)).substr(-2)
    if (gradients[newHex]) {
      return gradients[newHex]
    }
  }

  if (green < 255 - delta) {
    newHex = ('0' + red.toString(16)).substr(-2) +
      ('0' + (green + delta).toString(16)).substr(-2) +
      ('0' + blue.toString(16)).substr(-2)
    if (gradients[newHex]) {
      return gradients[newHex]
    }
  }

  if (blue < 255 - delta) {
    newHex = ('0' + red.toString(16)).substr(-2) +
      ('0' + green.toString(16)).substr(-2) +
      ('0' + (blue + delta).toString(16)).substr(-2)
    if (gradients[newHex]) {
      return gradients[newHex]
    }
  }

  return hex
}

function normalize(hex, hexObj, delta) {
  var red = parseInt(hex.substr(0, 2), 16)
  var green = parseInt(hex.substr(2, 2), 16)
  var blue = parseInt(hex.substr(4,2), 16)
  var lowest = Math.min(red, green, blue)
  var highest = Math.max(red, green, blue)
  var newHex

  // Do not normalize white, black, or shades of grey unless low delta
  if (lowest === highest) {
    if (delta < 32) {
      if (lowest === 0 || highest >= 255-delta) {
        return hex
      }
    }
    else {
      return hex
    }
  }

  for (; highest < 256; lowest += delta, highest += delta) {
    newHex = ('0' + (red - lowest).toString(16)).substr(-2) +
      ('0' + (green - lowest).toString(16)).substr(-2) +
      ('0' + (blue - lowest).toString(16)).substr(-2)

    if (hexObj[newHex]) {
      // same color, different brightness - use it instead
      return newHex
    }
  }

  return hex
}

function favorSaturatedHue(r, g, b) {
  return ((r-g)*(r-g) + (r-b)*(r-b) + (g-b)*(g-b))/65535*50
  // return ((r-g)*(r-g) + (r-b)*(r-b) + (g-b)*(g-b))/65535*50+1
}

function favorBrightExcludeWhite(r,g,b) {
  if (r>245 && g>245 && b>245) return 0
  return (r*r+g*g+b*b)/65535*20+1
}

exports.findAdjacent = findAdjacent
exports.normalize = normalize
exports.favorSaturatedHue = favorSaturatedHue
exports.favorBrightExcludeWhite = favorBrightExcludeWhite
