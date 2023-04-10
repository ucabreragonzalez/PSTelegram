Function Send-TelegramChatAction
{
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param
	(
		# Unique identifier for the target chat
		[Parameter(Position = 0, Mandatory = $true)]
		[int]
		$ChatId,
		# Type of action to broadcast
		[Parameter(Position = 1, Mandatory = $true)]
		[ValidateSet("typing", "upload_photo", "record_video", "upload_video", "record_voice", "upload_voice", "upload_document", "choose_sticker", "find_location", "record_video_note", "upload_video_note")]
		[String]
		$Action,
		#----------------------
		#TODO: Add more API options
		#----------------------
		# Unique authentication token given when bot was created
		[Parameter(Position = 2, Mandatory = $false)]
		[String]
		$Token
	)

	If ($PSCmdlet.ShouldProcess($Action, $ChatId))
	{
		try {
			# Buid parameters for sendChatAction
			$splat = @{
				APIMethod = "sendChatAction"
				Parameters = @{
					chat_id = $ChatId
					action = $Action
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
Notifies user that something is happening on the bot's side

.DESCRIPTION
Use this method when you need to tell the user that something is happening on the bot's side.
The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients clear its typing status).
Returns True on success.

.EXAMPLE
$Parameters = @{
    ChatId = 123456789
    Action = "typing"
	Token = "123456789:#################################"
}

Send-TelegramChatAction @Parameters

.LINK
https://core.telegram.org/bots/api#sendchataction
#>
}
