Function Set-TelegramCommands
{
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param
	(
		# List of bot commands to be set as the list of the bot's commands
		# the command itself should not contain spaces eg. 'command1' rather than 'command 1'.
		[Parameter(Position = 0, Mandatory = $true)]
		[System.Collections.ArrayList]
		$Commands,
		#----------------------
		#TODO: Add more API options
		#----------------------
		# Unique authentication token given when bot was created
		[Parameter(Mandatory = $false)]
		[String]
		$Token
	)

	If ($PSCmdlet.ShouldProcess($Commands, "Set list of commands"))
	{
		try {
			# Buid parameters for setMyCommands
			$splat = @{
				APIMethod = "setMyCommands"
				Parameters = @{
					commands = $Commands
				}
			}

			# If Token
			if($Token){
				$splat += @{Token = $Token}
			}

			return (Invoke-TelegramAPI @splat)
		}
		catch {
			Write-Error $_ -ErrorAction Stop
		}
	}
<#
.SYNOPSIS
Change the list of the a bot commands

.DESCRIPTION
Change the list of the a bot commands

.EXAMPLE
$Parameters = @{
    Commands = @(
        @{
            command = "command1"
            description = "description 1"
        },
        @{
            command = "command2"
            description = "description 2"
        }
    )
    Token = "123456789:#################################"
}

Set-TelegramCommands @Parameters

.LINK
https://core.telegram.org/bots/api#setmycommands

#>
}
