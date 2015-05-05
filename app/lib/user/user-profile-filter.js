'use strict';

var assert = require('assert');

module.exports = function userProfileFilter(user) {

  assert.equal(typeof (user), 'object', 'argument user must be an object');

  return Object.keys(user.providers).map(function (provider) {

    // TODO: google support only currently
    return {
      displayName: user.providers[provider].displayName,
      url: user.providers[provider].url,
      image: user.providers[provider].image.url,
      provider: provider
    };

  });

};
