App = {
  web3Provider: null,
  contracts: {},

  init: function() {
    return App.initWeb3();
  },

  initWeb3: function() {
    // Is there an injected web3 instance?
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
    } else {
      // If no injected web3 instance is detected, fall back to Ganache
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
    }
    web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  initContract: function() {
    $.getJSON('QuestionPosting.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract
      var QuestionPostingArtifact = data;
      App.contracts.QuestionPosting = TruffleContract(QuestionPostingArtifact);
    
      // Set the provider for our contract
      App.contracts.QuestionPosting.setProvider(App.web3Provider);
    
      // Use our contract to retrieve and mark the adopted pets
      return App.displayCurrentQuestion();
    });

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-post-question', App.handlePosting);
  },

  displayCurrentQuestion: function(question, account) {
    var questionPostingInstance;

    App.contracts.QuestionPosting.deployed().then(function(instance) {
      questionPostingInstance = instance;
    
      return questionPostingInstance.getQuestion.call();
    }).then(function(question) {
        $('#posted-question').text(question);
      }
    ).catch(function(err) {
      console.log(err.message);
    });
  },

  handlePosting: function(event) {
    event.preventDefault();
 
    var question = $("#inputQuestion").val();
    console.log("New input question:" + question);

    var questionPostingInstance;
    
    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }
    
      var account = accounts[0];
    
      App.contracts.QuestionPosting.deployed().then(function(instance) {
        questionPostingInstance = instance;
    
        return questionPostingInstance.postQuestion(question, {from: account});
      }).then(function(result) {
        return App.displayCurrentQuestion();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
