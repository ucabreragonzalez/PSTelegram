Function Send-TelegramMessage
{
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param
	(
		# Unique identifier for the target chat
		[Parameter(Position = 0, Mandatory = $true)]
		[int]
		$ChatId,
		# Text of the message to be sent
		[Parameter(Position = 1, Mandatory = $true)]
		[ValidateLength(1, 4096)]
		[String]
		$MessageText,
		# Mode for parsing entities in the message text
		[Parameter(Position = 2, Mandatory = $false)]
		[ValidateSet("MarkdownV2", "HTML", "Markdown")]
		[String]
		$ParseMode,
		#----------------------
		#TODO: Add more API options
		#----------------------
		# Unique authentication token given when bot was created
		[Parameter(Position = 3, Mandatory = $false)]
		[String]
		$Token
	)

	If ($PSCmdlet.ShouldProcess($MessageText, "Send message to chat: {0}" -f $ChatId))
	{
		try {
			# Buid parameters for sendMessage
			$splat = @{
				APIMethod = "sendMessage"
				Parameters = @{
					chat_id = $ChatId
					text = $MessageText
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
Used to send text messages

.DESCRIPTION
Use this method to send text messages. On success, the sent Message is returned.

.EXAMPLE
$Parameters = @{
    ChatId = 123456789
    MessageText = "Message from PSTelegram"
    Token = "123456789:#################################"
}

Send-TelegramMessage @Parameters

.LINK
https://core.telegram.org/bots/api#sendmessage
#>
}
