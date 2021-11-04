@ECHO OFF
REM
REM	ppd - PHP Putty deployment
REM	Creation      : 2021-11-04
REM @see https://github.com/coyote333666/ppd The ppd GitHub project
REM 
REM @author    Vincent Fortier <coyote333666@gmail.com>
REM @copyright 2021 Vincent Fortier
REM @license   http://www.gnu.org/copyleft/lesser.html GNU Lesser General Public License
REM @note      This program is distributed in the hope that it will be useful - WITHOUT
REM ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
REM FITNESS FOR A PARTICULAR PURPOSE.

dir *.scr
set /p SCR=Enter the name of the psftp script :
set /p SRV=Enter the server name :
REM convert script to ansi Windows format
cmd /a /c type "%SCR%"
PAUSE
cmd /a /c type "%SCR%" > "%SCR%".ansi
psftp -bc -be -b "%SCR%".ansi "%SRV%"
del "%SCR%".ansi
PAUSE