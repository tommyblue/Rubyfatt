if (window.location.search.indexOf("?test") !== -1) {
  document.write(
    '<div id="qunit"></div>' +
    '<div id="qunit-fixture"></div>' +
    '<div id="ember-testing-container">' +
    '  <div id="ember-testing"></div>' +
    '</div>' +
    '<link rel="stylesheet" href="/assets/tests/runner.css">' +
    '<link rel="stylesheet" href="/assets/tests/vendor/qunit-1.12.0.css">' +
    '<script src="/assets/tests/vendor/qunit-1.12.0.js"></script>' +
    '<script src="/assets/tests/tests.js"></script>'
  )
}
