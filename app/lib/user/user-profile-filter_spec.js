'use strict';

var should = require('chai').should(),
  fs = require('fs');

var config = require('../../../config'),
  userProfileFixture = JSON.parse(fs.readFileSync(config.get('root') + '/test/fixtures/user-profile-google.json')),
  profileFilter = require('./user-profile-filter');

describe('User', function () {

  describe('Profile Filter', function () {

    it('should filter user data from a stored provider oauth data object', function() {
      should.exist(profileFilter);

      var userProfile = profileFilter(userProfileFixture);

      userProfile[0].google.displayName.should.equal(userProfileFixture.providers.google.displayName);
      userProfile[0].google.url.should.equal(userProfileFixture.providers.google.url);
      userProfile[0].google.image.should.equal(userProfileFixture.providers.google.image.url);

      userProfile[1].facebook.displayName.should.equal(userProfileFixture.providers.facebook.displayName);
      userProfile[1].facebook.url.should.equal(userProfileFixture.providers.facebook.url);
      userProfile[1].facebook.image.should.equal(userProfileFixture.providers.facebook.image.url);

    });

  });

});
