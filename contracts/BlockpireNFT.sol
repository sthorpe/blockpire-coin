pragma solidity ^0.4.24;

/**
    @title ERC-1155 Multi Token Standard
    @dev Note: the ERC-165 identifier for this interface is 0xf23a6e61.
 */
interface ERC1155 {
    /**
        @dev MUST emit when tokens are transferred, including zero value transfers
    */
    event Transfer(address _spender, address indexed _from, address indexed _to, uint256 indexed _id, uint256 _value);

    /**
        @dev MUST emit on any successful call to approve(address _spender, uint256 _id, uint256 _currentValue, uint256 _value)
    */
    event Approval(address indexed _owner, address indexed _spender, uint256 indexed _id, uint256 _oldValue, uint256 _value);

    /**
        @dev MUST emit on any successful call to setApprovalForAll(address _operator, bool _approved)
    */
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    /**
        @dev Emits when the URI is updated for a token ID
    */
    event URI(uint256 indexed _id, string _value);

    /**
        @dev Emits when the Name is updated for a token ID
    */
    event Name(uint256 indexed _id, string _value);

    /**
        @notice Transfers value amount of an _id from the _from address to the _to addresses specified. Each parameter array should be the same length, with each index correlating.
        @dev MUST emit Transfer event on success.
        Caller must have sufficient allowance by _from for the _id/_value pair, or isApprovedForAll must be true.
        Throws if `_to` is the zero address.
        Throws if `_id` is not a valid token ID.
        When transfer is complete, this function checks if `_to` is a smart contract (code size > 0). If so, it calls `onERC1155Received` on `_to` and throws if the return value is not `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`.
        @param _from    source addresses
        @param _to      target addresses
        @param _id      ID of the Token
        @param _value   transfer amounts
        @param _data    Additional data with no specified format, sent in call to `_to`
    */
    function safeTransferFrom(address _from, address _to, uint256 _id, uint256 _value, bytes _data) external;

    /**
        @notice Send multiple types of Tokens from a 3rd party in one transfer (with safety call)
        @dev MUST emit Transfer event per id on success.
        Caller must have a sufficient allowance by _from for each of the id/value pairs.
        Throws on any error rather than return a false flag to minimize user errors.
        @param _from    Source address
        @param _to      Target address
        @param _ids     Types of Tokens
        @param _values  Transfer amounts per token type
        @param _data    Additional data with no specified format, sent in call to `_to`
    */
    function safeBatchTransferFrom(address _from, address _to, uint256[] _ids, uint256[] _values, bytes _data) external;

    /**
        @notice Allow other accounts/contracts to spend tokens on behalf of msg.sender
        @dev MUST emit Approval event on success.
        To minimize the risk of the approve/transferFrom attack vector (see https://docs.google.com/document/d/1YLPtQxZu1UAvO9cZ1O2RPXBbT0mooh4DYKjA_jp-RLM/), this function will throw if the current approved allowance does not equal the expected _currentValue, unless _value is 0.
        @param _spender      Address to approve
        @param _id           ID of the Token
        @param _currentValue Expected current value of approved allowance.
        @param _value        Allowance amount
    */
    function approve(address _spender, uint256 _id, uint256 _currentValue, uint256 _value) external;

    /**
        @notice Get the balance of an account's Tokens
        @param _id     ID of the Token
        @param _owner  The address of the token holder
        @return        The _owner's balance of the Token type requested
     */
    function balanceOf(uint256 _id, address _owner) external view returns (uint256);

    /**
        @notice Queries the spending limit approved for an account
        @param _id       ID of the Token
        @param _owner    The owner allowing the spending
        @param _spender  The address allowed to spend.
        @return          The _spender's allowed spending balance of the Token requested
     */
    function allowance(uint256 _id, address _owner, address _spender) external view returns (uint256);

    /**
        @notice Enable or disable approval for a third party ("operator") to manage all of `msg.sender`'s assets.
        @dev MUST emit the ApprovalForAll event on success.
        @param _operator  Address to add to the set of authorized operators
        @param _approved  True if the operator is approved, false to revoke approval
    */
    function setApprovalForAll(address _operator, bool _approved) external;

    /**
        @notice Queries the approval status of an operator for a given Token and owner
        @param _owner     The owner of the Tokens
        @param _operator  Address of authorized operator
        @return           True if the operator is approved, false if not
    */
    function isApprovedForAll(address _owner, address _operator) external view returns (bool isOperator);
}
