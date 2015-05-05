'use strict';

var should = require('chai').should(),
  fs = require('fs');

var config = require('../../../config'),
  userProfileFixture = JSON.parse(fs.readFileSync(config.get('root') + '/test/fixtures/user-profile-google.json')),
  profileFilter = require('./user-profile-filter');

describe('User', function () {

  describe('Profile Filter', function () {

    it('should', function() {
      should.exist(profileFilter);

      var userProfile = profileFilter(userProfileFixture);

      userProfile[0].displayName.should.equal(userProfileFixture.providers.google.displayName);
      userProfile[0].url.should.equal(userProfileFixture.providers.google.url);
      userProfile[0].image.should.equal(userProfileFixture.providers.google.image.url);
      userProfile[0].provider.should.equal('google');

    });

  });

});
