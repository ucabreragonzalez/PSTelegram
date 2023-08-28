Function Set-TelegramCommands
{
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param
	(
		# Unique identifier for the target chat
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

			# If ParseMode
			if($ParseMode){
				$splat.Parameters += @{parse_mode = $ParseMode}
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

.PARAMETER Name

.INPUTS

.OUTPUTS

.EXAMPLE

.LINK

#>
}
