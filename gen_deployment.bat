@ECHO OFF
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
REM
REM Description   : DOS script calling a powershell script to generate a production release script (.scr)
REM           To run this script:
REM                 gen_deployment.bat
REM Parameter     : ID = batch id
REM                 APP = application name
REM	 				EXT = file extension
REM 

echo today's date : %date%
set EXT=php
echo ----------
set /p ID=Enter batch id :
set /p APP=Enter application name :
set /p EXT=Enter file extension string ("php" by default) :

powershell.exe -File gen_deployment.ps1 "%ID%" "%APP%" "%EXT%"
