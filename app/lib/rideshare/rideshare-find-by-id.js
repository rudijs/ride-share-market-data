'use strict';

var assert = require('assert'),
  q = require('q');

var config = require('../../../config'),
  mongodbFind = require(config.get('root') + '/app/lib/util/util-mongodb-find');

module.exports = function findById(logger, mongoose, rideshareId) {

  assert.equal(typeof (logger), 'object', 'argument logger must be an object');
  assert.equal(typeof (mongoose), 'object', 'argument mongoose must be an object');
  assert.equal(typeof (rideshareId), 'string', 'argument rideshareId must be a string');

  var deferred = q.defer();

  var findQuery = {
    modelName: 'Rideshare',
    conditions: {
      _id: rideshareId
    }
  };

  mongodbFind(logger, mongoose, findQuery).then(
    function mongodbFindSuccess(res) {

      if (!res.length) {
        deferred.reject({
          code: 404,
          message: 'not_found',
          data: 'Rideshare not found.'
        });
      }
      else {
        deferred.resolve(res);
      }

    })
    .catch(function (err) {
      deferred.reject(err);
    })
    .done();

  return deferred.promise;

};
