Function Get-TelegramUpdates
{
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param
	(
		# Identifier of the first update to be returned
		# Must be greater by one than the highest previously received from updates
		[Parameter(Position = 0, Mandatory = $false)]
		[int]
		$Offset,
		# Limits the number of updates to be retrieved. Defaults to 100.
		[Parameter(Position = 1, Mandatory = $false)]
		[ValidateRange(1, 100)]
		[int]
		$Limit = 100,
		# Unique authentication token given when bot was created
		[Parameter(Position = 2, Mandatory = $false)]
		[String]
		$Token
	)

	If ($PSCmdlet.ShouldProcess($Token, "Request Telegram Updates"))
	{
		try {
			# Buid parameters
			$splat = @{
				APIMethod = "getUpdates"
			}

			$Parameters = @{}

			# If $Offset
			if ($Offset) {
				$Parameters += @{
					offset = $Offset
				}
			}

			# If $Limit
			if ($Limit) {
				$Parameters += @{
					limit = $Limit
				}
			}

			# If got any parameter
			if ($Parameters.Count -gt 0) {
				$splat += @{Parameters = $Parameters}
			}

			# If Token
			if($Token) {
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
Receive incoming unconfirmed updates using long polling

.DESCRIPTION
Receive incoming unconfirmed updates using long polling
An update is considered confirmed as soon as getUpdates is called with an offset
Updates will not be kept longer than 24 hours.

.EXAMPLE
# get first 10 unconfirmed updates
Get-TelegramUpdates -Limit 10

.EXAMPLE
# get first 100 (Default) unconfirmed updates where offset (update_id) is 123456789 or higher
# This will confirm previous update_id's and All previous updates will be forgotten.
Get-TelegramUpdates -Offset 123456789

.LINK
https://core.telegram.org/bots/api#getupdates
#>
}
