pragma solidity ^0.4.19;

contract PersonRegistry
{
  // govid depends on agency, may be a DL or passport number or social or ...
  event Person( address indexed ethaddr, string govid );

  address public agency;

  modifier onlyAgency {
    if (msg.sender != agency) { revert(); }
    _;
  }

  function PersonRegistry() {
    agency = msg.sender;
  }

  function() payable { revert(); }

  function register( address ethaddr, string govid ) onlyAgency {
    Person( ethaddr, govid );
  }

  function closedown() onlyAgency {
    selfdestruct(agency);
  }
}
