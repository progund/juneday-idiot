/*****
 *                                                                   
 *                   Searduino
 *                      
 *   Copyright (C) 2013 Henrik Sandklef 
 *                                                                   
 * This program is free software; you can redistribute it and/or     
 * modify it under the terms of the GNU General Public License       
 * as published by the Free Software Foundation; either version 3    
 * of the License, or any later version.                             
 *                                                                   
 *                                                                   
 * This program is distributed in the hope that it will be useful,   
 * but WITHOUT ANY WARRANTY; without even the implied warranty of    
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the     
 * GNU General Public License for more details.                      
 *                                                                   
 * You should have received a copy of the GNU General Public License 
 * along with this program; if not, write to the Free Software       
 * Foundation, Inc., 51 Franklin Street, Boston,            
 * MA  02110-1301, USA.                                              
 ****/

#include <Arduino.h>
#include "LiquidCrystal.h"

LiquidCrystal lcd(8, 9, 4, 5, 6, 7);   // init LiquidCrystal 

extern "C" {

  void lcd_setup() {
    lcd.begin(16, 2);
    lcd.clear();                          
    lcd.setCursor(0,0);                   
  }

  void write_lcd(char *text)
  {
      lcd.setCursor(0,0);
      lcd.print(text);    
  }

  void scroll_lcd(char *text, char *prev)
  {
    int i ;
    int len;

    lcd.setCursor(0,0);
    lcd.print(text);
    lcd.setCursor(0,1);
    lcd.print(prev);

    len = strlen(text); 
    if (len>13)
      {
	for (i=0;i<len;i++)
	  {
	    lcd.scrollDisplayLeft();
	    delay (400);
	  }
	lcd.setCursor(0,0);
	lcd.print(text);
	lcd.setCursor(0,1);
	lcd.print(prev);
      }
  }
}
