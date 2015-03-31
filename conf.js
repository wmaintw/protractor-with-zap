// conf.js
exports.config = {
  seleniumAddress: 'http://localhost:4444/wd/hub',
  specs: ['demo_spec.js'],
  capabilities: {
    browserName: 'chrome',

    proxy: {
      proxyType: process.env.PROTRACTOR_PROXY_TYPE == null ? 'direct' : process.env.PROTRACTOR_PROXY_TYPE,
      httpProxy: process.env.PROTRACTOR_HTTP_PROXY
    }
  }
}
