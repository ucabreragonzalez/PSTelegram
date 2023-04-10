Function Invoke-TelegramAPI
{
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param
	(
		# Inline parameter help comment
		[Parameter(Position = 1, Mandatory = $false)]
		[psobject]
		$Parameters,
		# Inline parameter help comment
		[Parameter(Position = 2, Mandatory = $false)]
		[string]
		$APIMethod,
		# Unique authentication token given when bot was created.
		[Parameter(Position = 0, Mandatory = $false)]
		[string]
		$Token = $Global:TelegramToken
	)

	If ($PSCmdlet.ShouldProcess($Token, "Invoke Telegram API for given parameters"))
	{
		try {
			if ([string]::IsNullOrEmpty($Token)) {
				Write-Error "Error calling Telegram API, Token not found. Provide it through parameter or declare it with Set-TelegramSessionToken." -ErrorAction Stop
			}

			$headers=@{}
			$headers.Add("accept", "application/json")
			$headers.Add("content-type", "application/json")

			$request_params = @{
				Uri 	= "https://api.telegram.org/bot$token/$APIMethod"
				Method 	= "POST"
				Headers = $headers
			}

			if ($Parameters) {
				$request_params += @{
					Body = ConvertTo-Json $Parameters -Depth 50 -Compress
				}
			}

			$response = Invoke-RestMethod @request_params

			return $response
		}
		catch {
			Write-Error $_ -ErrorAction Stop
		}
	}
<#
.SYNOPSIS
It calls the API for given parameters and returns the response

.DESCRIPTION
It calls the API for given parameters and returns the response

.EXAMPLE
Invoke-TelegramAPI -APIMethod "sendMessage" -Parameters @{chat_id = "123456789"; text = "Text Message"} -Token "123456789:#################################"

.EXAMPLE
Set-TelegramSessionToken -Token "123456789:#################################"
Invoke-TelegramAPI -APIMethod "sendMessage" -Parameters @{chat_id = "123456789"; text = "Text Message"}

.LINK
https://core.telegram.org/bots/api#making-requests

.LINK
https://telegram-bot-sdk.readme.io/reference
#>
}
