function(add_common_flags target)
	get_target_property(target_type ${target} TYPE)
	message("The target type is ${target_type}")

	if(CMAKE_CXX_COMPILER_ID MATCHES MSVC)
		# set_property(TARGET ${target} APPEND_STRING PROPERTY LINK_FLAGS_DEBUG "/DEBUG /INCREMENTAL")
		# set_property(TARGET ${target} APPEND_STRING PROPERTY LINK_FLAGS_RELEASE "/DEBUG /LTCG /INCREMENTAL:NO /OPT:REF")
		# set_property(TARGET ${target} APPEND PROPERTY COMPILE_OPTIONS -DWIN32 -D_WINDOWS)
		# set_property(TARGET ${target} APPEND PROPERTY COMPILE_OPTIONS /GS- /W3 /WX- /MP /nologo /bigobj /wd4577 /wd4530)

		# if(GGPO_64BIT) # Debug edit and continue for 64-bit
		# 	set_property(TARGET ${target} APPEND PROPERTY COMPILE_OPTIONS $<$<CONFIG:Debug>:/ZI>)
		# 	message("\nPROJECT SET TO MSVC 64 BITS VERSION!\n")
		# else() # Normal debug for 32-bit
		# 	set_property(TARGET ${target} APPEND PROPERTY COMPILE_OPTIONS $<$<CONFIG:Debug>:/Zi>)
		# 	message("\nPROJECT SET TO MSVC 32 BITS VERSION!\n")
		# endif()

		# set_property(TARGET ${target} APPEND PROPERTY COMPILE_OPTIONS $<$<CONFIG:Release>:/GL /Gy /Zi /O2 /Oi /MD -DNDEBUG>)

		message("\nPROJECT SET TO MSVC VERSION!\n")

		set_property(TARGET ${target} APPEND_STRING PROPERTY LINK_FLAGS_DEBUG "/DEBUG:FULL /INCREMENTAL")
		set_property(TARGET ${target} APPEND_STRING PROPERTY LINK_FLAGS_RELEASE "/DEBUG:FULL /INCREMENTAL:NO")
		set_property(TARGET ${target} APPEND_STRING PROPERTY LINK_FLAGS_RELWITHDEBINFO "/DEBUG:FULL /INCREMENTAL:NO")
		set_property(TARGET ${target} APPEND PROPERTY COMPILE_OPTIONS $<$<CONFIG:Debug>:/Od /std:c++${CMAKE_C_STANDARD} /Zi /Zf /Zo /W4 /MP /nologo /bigobj /GS- /MDd /WX- /D_WIN32>)
		set_property(TARGET ${target} APPEND PROPERTY COMPILE_OPTIONS $<$<CONFIG:Release>:/O2 /std:c++${CMAKE_C_STANDARD} /Zo /W4 /MP /nologo /bigobj /GS- /MD /WX- /D_WIN32>)
		set_property(TARGET ${target} APPEND PROPERTY COMPILE_OPTIONS $<$<CONFIG:RelWithDebInfo>:/Ox /std:c++${CMAKE_C_STANDARD} /Zi /Zf /Zo /W4 /MP /nologo /bigobj /GS- /MD /WX- /D_WIN32>)

	elseif(CMAKE_CXX_COMPILER_ID MATCHES GNU)
		# GCC compile options by Build Type on 64 and 32 bits

		if(GGPO_64BIT) # 64-bit compilation
			# set_property(TARGET ${target} APPEND PROPERTY COMPILE_OPTIONS $<$<CONFIG:Debug>:-fdiagnostics-color=always -g3 -O0 -flto -ggdb -pedantic -Wall
			#  -Weffc++ -Wextra -Wconversion -Wsign-conversion -std=c++20 -o>)
			# set_property(TARGET ${target} APPEND PROPERTY COMPILE_OPTIONS $<$<CONFIG:Release>:-fdiagnostics-color=always -g3 -O3 -flto -DNDEBUG -pedantic
			#  -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -std=c++20 -o>)
			message("\nPROJECT SET TO GCC 64 BITS VERSION!\n")
			set(CMAKE_C_FLAGS_DEBUG "-v -fdiagnostics-color=always -m64 -O0 -g3 -Wpedantic -fsanitize=undefined -fsanitize-trap=all -std=c${CMAKE_C_STANDARD}" CACHE STRING "" FORCE)
			set(CMAKE_C_FLAGS_RELEASE "-v -fdiagnostics-color=always -m64 -O3 -g0 -Wpedantic -std=c${CMAKE_C_STANDARD}" CACHE STRING "" FORCE)
			set(CMAKE_C_FLAGS_RELWITHDEBINFO "-v -fdiagnostics-color=always -m64 -O2 -g3 -Wpedantic -std=c${CMAKE_C_STANDARD}" CACHE STRING "" FORCE)
			message("1) The compilation flags for the C Debug build type are ${CMAKE_C_FLAGS_DEBUG}\n")
			message("2) The compilation flags for the C Release build type are ${CMAKE_C_FLAGS_RELEASE}\n")
			message("3) The compilation flags for the C RelWithDebInfo build type are is ${CMAKE_C_FLAGS_RELWITHDEBINFO}\n")

			set(CMAKE_CXX_FLAGS_DEBUG "-v -fdiagnostics-color=always -m64 -O0 -g3 -Wpedantic -fsanitize=undefined -fsanitize-trap=all -std=c++${CMAKE_CXX_STANDARD}" CACHE STRING "" FORCE)
			set(CMAKE_CXX_FLAGS_RELEASE "-v -fdiagnostics-color=always -m64 -O3 -g0 -Wpedantic -std=c++${CMAKE_CXX_STANDARD}" CACHE STRING "" FORCE)
			set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-v -fdiagnostics-color=always -m64 -O2 -g3 -Wpedantic -std=c++${CMAKE_CXX_STANDARD}" CACHE STRING "" FORCE)
			message("4) The compilation flags for the C++ Debug build type are ${CMAKE_CXX_FLAGS_DEBUG}\n")
			message("5) The compilation flags for the C++ Release build type are ${CMAKE_CXX_FLAGS_RELEASE}\n")
			message("6) The compilation flags for the C++ RelWithDebInfo build type are ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}\n")

		else() # 32-bit compilation
			message("\nPROJECT SET TO GCC 32 BITS VERSION!\n")
			set(CMAKE_C_FLAGS_DEBUG "-v -fdiagnostics-color=always -m32 -O0 -g3 -Wpedantic -fsanitize=undefined -fsanitize-trap=all -std=c${CMAKE_C_STANDARD}" CACHE STRING "" FORCE)
			set(CMAKE_C_FLAGS_RELEASE "-v -fdiagnostics-color=always -m32 -O3 -g0 -Wpedantic -std=c${CMAKE_C_STANDARD}" CACHE STRING "" FORCE)
			set(CMAKE_C_FLAGS_RELWITHDEBINFO "-v -fdiagnostics-color=always -m32 -O2 -g3 -Wpedantic -std=c${CMAKE_C_STANDARD}" CACHE STRING "" FORCE)
			message("1) The compilation flags for the C Debug build type are ${CMAKE_C_FLAGS_DEBUG}\n")
			message("2) The compilation flags for the C Release build type are ${CMAKE_C_FLAGS_RELEASE}\n")
			message("3) The compilation flags for the C RelWithDebInfo build type are is ${CMAKE_C_FLAGS_RELWITHDEBINFO}\n")

			set(CMAKE_CXX_FLAGS_DEBUG "-v -fdiagnostics-color=always -m32 -O0 -g3 -Wpedantic -fsanitize=undefined -fsanitize-trap=all -std=c++${CMAKE_CXX_STANDARD}" CACHE STRING "" FORCE)
			set(CMAKE_CXX_FLAGS_RELEASE "-v -fdiagnostics-color=always -m32 -O3 -g0 -Wpedantic -std=c++${CMAKE_CXX_STANDARD}" CACHE STRING "" FORCE)
			set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-v -fdiagnostics-color=always -m32 -O2 -g3 -Wpedantic -std=c++${CMAKE_CXX_STANDARD}" CACHE STRING "" FORCE)
			message("4) The compilation flags for the C++ Debug build type are ${CMAKE_CXX_FLAGS_DEBUG}\n")
			message("5) The compilation flags for the C++ Release build type are ${CMAKE_CXX_FLAGS_RELEASE}\n")
			message("6) The compilation flags for the C++ RelWithDebInfo build type are ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}\n")
		endif()

	elseif(CMAKE_CXX_COMPILER_ID MATCHES Clang)
		# CLANG compile options by Build Type on 64 and 32 bits

		if(GGPO_64BIT) # 64-bit compilation
			# -Weverything
			message("\nPROJECT SET TO CLANG 64 BITS VERSION!\n")
			set(CMAKE_C_FLAGS_DEBUG "-v -fdiagnostics-color=always -g3 -glldb -fuse-ld=lld -m64 -fstandalone-debug -O0 -Wpedantic -fsanitize=undefined -fsanitize-trap=all -std=c${CMAKE_C_STANDARD} -o" CACHE STRING "" FORCE)
			set(CMAKE_C_FLAGS_RELEASE "-v -fdiagnostics-color=always -fuse-ld=lld -m64 -O3 -g0 -Wpedantic -std=c${CMAKE_C_STANDARD} -o" CACHE STRING "" FORCE)
			set(CMAKE_C_FLAGS_RELWITHDEBINFO "-v -fdiagnostics-color=always -glldb -fuse-ld=lld -m64 -g3 -fstandalone-debug -O2 -Wpedantic -std=c${CMAKE_C_STANDARD} -o" CACHE STRING "" FORCE)
			message("1) The compilation flags for the C Debug build type are ${CMAKE_C_FLAGS_DEBUG}\n")
			message("2) The compilation flags for the C Release build type are ${CMAKE_C_FLAGS_RELEASE}\n")
			message("3) The compilation flags for the C RelWithDebInfo build type are is ${CMAKE_C_FLAGS_RELWITHDEBINFO}\n")

			set(CMAKE_CXX_FLAGS_DEBUG "-v -fdiagnostics-color=always -g3 -glldb -fuse-ld=lld -m64 -fstandalone-debug -O0 -Wpedantic -fsanitize=undefined -fsanitize-trap=all -std=c++${CMAKE_CXX_STANDARD} -o" CACHE STRING "" FORCE)
			set(CMAKE_CXX_FLAGS_RELEASE "-v -fdiagnostics-color=always -fuse-ld=lld -m64 -O3 -g0 -Wpedantic -std=c++${CMAKE_CXX_STANDARD} -o" CACHE STRING "" FORCE)
			set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-v -fdiagnostics-color=always -glldb -fuse-ld=lld -m64 -g3 -fstandalone-debug -O2 -Wpedantic -std=c++${CMAKE_CXX_STANDARD} -o" CACHE STRING "" FORCE)
			message("4) The compilation flags for the C++ Debug build type are ${CMAKE_CXX_FLAGS_DEBUG}\n")
			message("5) The compilation flags for the C++ Release build type are ${CMAKE_CXX_FLAGS_RELEASE}\n")
			message("6) The compilation flags for the C++ RelWithDebInfo build type are ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}\n")

		else() # 32-bit compilation
			message("\nPROJECT SET TO CLANG 32 BITS VERSION!\n")
			set(CMAKE_C_FLAGS_DEBUG "-v -fdiagnostics-color=always -g3 -glldb -fuse-ld=lld -m32 -fstandalone-debug -O0 -Wpedantic -fsanitize=undefined -fsanitize-trap=all -std=c${CMAKE_C_STANDARD} -o" CACHE STRING "" FORCE)
			set(CMAKE_C_FLAGS_RELEASE "-v -fdiagnostics-color=always -fuse-ld=lld -m32 -O3 -g0 -Wpedantic -std=c${CMAKE_C_STANDARD} -o" CACHE STRING "" FORCE)
			set(CMAKE_C_FLAGS_RELWITHDEBINFO "-v -fdiagnostics-color=always -glldb -fuse-ld=lld -m32 -g3 -fstandalone-debug -O2 -Wpedantic -std=c${CMAKE_C_STANDARD} -o" CACHE STRING "" FORCE)
			message("1) The compilation flags for the C Debug build type are ${CMAKE_C_FLAGS_DEBUG}\n")
			message("2) The compilation flags for the C Release build type are ${CMAKE_C_FLAGS_RELEASE}\n")
			message("3) The compilation flags for the C RelWithDebInfo build type are is ${CMAKE_C_FLAGS_RELWITHDEBINFO}\n")

			set(CMAKE_CXX_FLAGS_DEBUG "-v -fdiagnostics-color=always -g3 -glldb -fuse-ld=lld -m32 -fstandalone-debug -O0 -Wpedantic -fsanitize=undefined -fsanitize-trap=all -std=c++${CMAKE_CXX_STANDARD} -o" CACHE STRING "" FORCE)
			set(CMAKE_CXX_FLAGS_RELEASE "-v -fdiagnostics-color=always -fuse-ld=lld -m32 -O3 -g0 -Wpedantic -std=c++${CMAKE_CXX_STANDARD} -o" CACHE STRING "" FORCE)
			set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-v -fdiagnostics-color=always -glldb -fuse-ld=lld -m32 -g3 -fstandalone-debug -O2 -Wpedantic -std=c++${CMAKE_CXX_STANDARD} -o" CACHE STRING "" FORCE)
			message("4) The compilation flags for the C++ Debug build type are ${CMAKE_CXX_FLAGS_DEBUG}\n")
			message("5) The compilation flags for the C++ Release build type are ${CMAKE_CXX_FLAGS_RELEASE}\n")
			message("6) The compilation flags for the C++ RelWithDebInfo build type are ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}\n")

			#set(LINK_FLAGS_RELEASE "-DLLVM_USE_LINKER=ld" CACHE STRING "" FORCE)
		endif()
	endif()
endfunction()
