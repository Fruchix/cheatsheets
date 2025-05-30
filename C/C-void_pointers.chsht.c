/****************************************************************************
 * Copyright 2025 Fruchix                                                   *
 *                                                                          *
 * Licensed under the Apache License, Version 2.0 (the "License");          *
 * you may not use this file except in compliance with the License.         *
 * You may obtain a copy of the License at                                  *
 *                                                                          *
 *     http://www.apache.org/licenses/LICENSE-2.0                           *
 *                                                                          *
 * Unless required by applicable law or agreed to in writing, software      *
 * distributed under the License is distributed on an "AS IS" BASIS,        *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. *
 * See the License for the specific language governing permissions and      *
 * limitations under the License.                                           *
 ****************************************************************************/

// KEYWORDS: universal generic void pointer address arithmetic assign uintptr ptr

// Universal pointer: (void *), which should be of size 64 bits on majority of architectures

// write at address pointed by pointer
void *ptr;                      // ptr->[]

// need to convert ptr to be a pointer to the type that we want to write
*((unsigned long *)ptr) = 15;   // ptr->[15]
// here I want to write a pointer (void*), so ptr should be considered as a pointer to a pointer (void **)
*((void **)ptr) = 0x00001234;   // ptr->[0x00001234] where 0x00001234 is a pointer to address 0x00001234

void *next = malloc(sizeof(void *));
*((void **)next) = 0xDEADBEEF;
*((void **)ptr) = next;   // ptr->[next] with next->[0xDEADBEEF]


// convert universal pointer to an integer (else the conversion does not have any type and won't work)
#include <stdint.h>
(uintptr_t)ptr;
