pragma solidity ^0.4.15;

contract VehicleRegistry {

  event Transfer( address indexed _from,
                  address indexed _to,
                  string          _vin );

  address public agency;
  uint256 public fee;

  modifier onlyAgency {
    if (msg.sender != agency) { revert(); }
    _;
  }

  modifier feeCheck {
    if (msg.value < fee) revert();
    _;
  }

  function VehicleRegistry() {
    agency = msg.sender;
    fee = 4 finney; // about $1
  }

  function() payable { revert(); }

  function register( string vin ) feeCheck payable {
    Transfer( agency, msg.sender, vin );
  }

  function transfer( address to, string vin ) feeCheck payable {
    Transfer( msg.sender, to, vin );
  }

  function dispose( string vin ) feeCheck payable {
    Transfer( msg.sender, agency, vin );
  }

  function assign( address to, string vin ) onlyAgency {
    Transfer( agency, to, vin );
  }

  function setFee( uint newfee ) onlyAgency { fee = newfee; }

  function withdraw( uint amt ) onlyAgency returns (bool) {
    return agency.send( amt );
  }

  function closedown() onlyAgency {
    selfdestruct(agency);
  }
}
