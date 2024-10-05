function keysAfterArsortNumeric(obj) {
  var result = []

  var bridge = []
  for (var key in obj) {
    bridge.push({
      key: key,
      value: obj[key]
    })
  }

  bridge = bridge.sort(function(a, b) {
    return b.value - a.value
  })

  bridge.forEach(function(item) {
    result.push(item.key)
  })

  return result
}

exports.keysAfterArsortNumeric = keysAfterArsortNumeric