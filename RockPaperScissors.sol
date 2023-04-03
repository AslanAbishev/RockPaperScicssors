// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract RockPaperScissors{
    constructor() payable {
        
    }
    enum GameChoice {Rock, Paper, Scissors}
    event GameEnd(address player, bool isWinner);

    function play(uint8 _gameChoice) payable public{
        require(_gameChoice <= 2,"U can choose only 0 (Rock), 1 (Paper), 2 (Scissors)");
        require(msg.value >= 100000000000000,"min bet is 0.0001 tBnb");
        require(address(this).balance >= msg.value*2,"Smart-contract run out of funds");

        uint256 _output = block.timestamp%3;//sozdanie randoma
        GameChoice _randomOption = GameChoice(_output);
        GameChoice _yourOption = GameChoice(_gameChoice);

        if(_randomOption == _yourOption){
            emit GameEnd(msg.sender, false);
            return;
        }
        bool _isWinner;
        if(_yourOption == GameChoice.Rock && _randomOption == GameChoice.Scissors ||
           _yourOption == GameChoice.Paper && _randomOption == GameChoice.Rock ||
           _yourOption == GameChoice.Scissors && _randomOption == GameChoice.Paper){
               _isWinner = true;
               payable(msg.sender).transfer(msg.value * 2);
           }
           else{
               _isWinner = false;
           }
        emit GameEnd(msg.sender, _isWinner);

    }
    receive() external payable {

    }
}