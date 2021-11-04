#
# ppd - PHP Putty deployment
# Creation      : 2021-11-04
# @see https://github.com/coyote333666/ppd The ppd GitHub project
# 
# @author    Vincent Fortier <coyote333666@gmail.com>
# @copyright 2021 Vincent Fortier
# @license   http://www.gnu.org/copyleft/lesser.html GNU Lesser General Public License
# @note      This program is distributed in the hope that it will be useful - WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.
#
# Description   : POWERSHELL script to generate a .scr script used by psftp
#                 this script is called by gen_deployment.bat
#                 To run this script without gen_deployment.bat : 
#                 powershell.exe -File deployment.ps1 <$id> <$app> <$ext>
# Parametre     : $id = batch id
#                 $app = application name
#				  $ext = file extension ("php" by default)

param([string]$id, [string]$app, [string]$ext)

try
{
    $scr_file = $app + "_" + $id + "_" + $ext + ".scr"
    $rollback_file = $app + "_" + $id + "_" + $ext + "_ROLLBACK.scr"
    $today = get-date -format "yyyy-MM-dd"
    $source_path = "\source\path\$app"
    $modif_files = get-childitem $source_path -include *.$ext -rec | select-string -pattern $id | Sort-Object |  Select-Object Path  | Get-Unique -AsString
    $remote_path = "/remote/path/$app"

    echo "# ****************************************************************************" > $scr_file 
    echo "# Batch id                          : $id" >> $scr_file
    echo "# Application name                  : $app" >> $scr_file
    echo "# ****************************************************************************" >> $scr_file

    copy $scr_file $rollback_file

    foreach ($modif_file in $modif_files)
    {
        $pos = $modif_file.Path.IndexOf($app)
        $remote_file = $remote_path + $modif_file.Path.Substring($pos).replace("\","/")
        $host_file = $modif_file.Path
        echo "del $remote_file.bak" >> $scr_file
        echo "ren $remote_file $remote_file.bak" >> $scr_file
        echo "put $host_file $remote_file" >> $scr_file

        # Rollback
        echo "del $remote_file" >> $rollback_file
        echo "ren $remote_file.bak $remote_file" >> $rollback_file
    }
    echo "quit" >> $scr_file
    echo "quit" >> $rollback_file
}
catch [Exception]
{
    write-output ("Error: {0}" -f $_.Exception.Message)
	pause 
    exit 1
}