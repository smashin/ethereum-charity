contract Charity {
    address public Owner;
    address[] public Projects;

    function Charity() {
        Owner = msg.sender;
    }

    function addProject(address project) {
        require(project != address(0));

        if (msg.sender == Owner) {
            if (projectExists(project) == false) {
                Projects.push(project);
            }
        }
    }

    function donate(uint amount, address[] recipients) payable {
        require (msg.sender.balance >= amount);

        var share = amount / recipients.length;
        for (uint i = 0; i < recipients.length; i++) {
            assert(projectExists(recipients[i]) == true);

            recipients[i].transfer(share);
        }
    }

    function projectExists(address value) returns (bool) {
        for (uint i = 0; i < Projects.length; i++) {
            if (Projects[i] == value) {
                return true;
            }
        }

        return false;
    }
}