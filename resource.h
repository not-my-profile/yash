/* Yash: yet another shell */
/* resource.h: ulimit builtin */
/* (C) 2007-2008 magicant */

/* This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.  */


#ifndef RESOURCE_H
#define RESOURCE_H


extern int ulimit_builtin(int argc, void **argv)
    __attribute__((nonnull));
extern const char ulimit_help[];


#endif /* RESOURCE_H */


/* vim: set ts=8 sts=4 sw=4 noet: */
