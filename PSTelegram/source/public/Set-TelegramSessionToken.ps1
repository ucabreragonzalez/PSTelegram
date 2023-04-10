Function Set-TelegramSessionToken
{
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param
	(
		# Unique authentication token given when bot was created
		[Parameter(Position = 0, Mandatory = $true)]
		[String]
		$Token
	)

	If ($PSCmdlet.ShouldProcess($Token, "Create global variable with value: {0}" -f $Token))
	{
		Set-Variable -Name "TelegramToken" -Value $Token -Scope Global
	}
<#
.SYNOPSIS
It creates a global variable with token available to all scripts, functions, or any cmdlet within the current session

.DESCRIPTION
It creates a global variable with token available to all scripts, functions, or any cmdlet within the current session

.EXAMPLE
Set-TelegramSessionToken -token "123456789:#################################"
#>
}
