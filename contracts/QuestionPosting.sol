pragma solidity ^0.4.23;

// import "./ownable.sol";

contract QuestionPosting {
  string public question = "What will be the first question?";
  address public questionOwner;

  event NewQuestionPosting(string question);

  function postQuestion(string _question) public {
    // Check for empty strings
    require(bytes(_question).length > 0);

    question = _question;
    questionOwner = msg.sender;
  }
  
  /// @dev one has to explicitely create a getter for the string type
  function getQuestion() public view returns(string) {
    return question;
  }
}

/*
/// @title A contract describing a Question posting
/// @author Visage
/// @notice A Question posting costs a certain cost used to reward the approved submissions
contract QuestionPosting is Ownable {
  using SafeMath for uint256;
  using SafeMath for uint16;

  event NewQuestionPosting(uint questionId, string question);

  uint questionPostingFee = 0.001 ether;
  uint submissionsDuration = 5 days;

  struct Question {
    string question;
    uint32 submissionsClosingTime;
    uint16 submittedQuestionsCount;
  }

  Question[] public questionPostings;

  mapping (uint => address) public questionToOwner;
  mapping (address => uint) ownerQuestionsCount;

  modifier onlyOwnerOf(uint _questionId) {
    require(msg.sender == questionToOwner[_questionId]);
    _;
  }

  function setQuestionPostingFee(uint _fee) external onlyOwner {
    questionPostingFee = _fee;
  }

  function setSubmissionsDuration(uint _duration) external onlyOwner {
    submissionsDuration = _duration;
  }

  /// @notice Post a new Question
  /// @param question the string of the question
  /// @return nothing!
  /// @dev This function can only be used by owner because we don't want others 
  /// to post instead of someone, even if they pay for it
  function postQuestion(string _question) external payable onlyOwner {
    require(msg.value == questionPostingFee);
    uint id = questionPostings.push(Question(_question, uint32(now + submissionsDuration), 0)) - 1;
    ownerQuestionsCount[msg.sender] = ownerQuestionsCount[msg.sender].add(1);
    emit NewQuestionPosting(id, _question);
    questionToOwner[id] = msg.sender;
  }

  /// @notice simply returns a question content
  /// @param _questionId the id of the question
  /// @return question content (string)
  function getQuestionContent(uint _questionId) public returns (string) {
    return questionPostings[_questionId].question;
  }

  function storeAnswer(uint _questionId) external;

  /// @notice Assess an answer submission
  /// @param submissionId id of the answer submission
  /// @param approval true if the question poster approved the answer
  /// @return nothing!
  function assessAnswer(uint submissionId, bool approval) external onlyOwner;
}
*/