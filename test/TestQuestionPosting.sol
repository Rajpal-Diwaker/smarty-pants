pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/QuestionPosting.sol";


contract TestQuestionPosting {
  QuestionPosting questionPost = QuestionPosting(DeployedAddresses.QuestionPosting());

  function stringToBytes32(string memory source) public pure returns (bytes32 result) {
      bytes memory tempEmptyStringTest = bytes(source);
      if (tempEmptyStringTest.length == 0) {
          return 0x0;
      }
      assembly {
          result := mload(add(source, 32))
      }
  }

  function testUserCanPostQuestion() public {
    string memory testQuestion = "what is the question?";
    questionPost.postQuestion(testQuestion);
    Assert.equal(stringToBytes32(testQuestion), stringToBytes32(testQuestion), "The contract question should be the test input.");
  }
}
