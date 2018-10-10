if (NOT VENV_DIR)
    set(VENV_DIR "${CMAKE_CURRENT_BINARY_DIR}/msgpack-venv")

    if(WIN32)
        set(BASEPYEXE py.exe -3)
        set(PYEXE "${VENV_DIR}/Scripts/python.exe")
        set(SIX_LOC "${VENV_DIR}/Lib/site-packages/six.py")
    else()
        set(BASEPYEXE python3)
        set(PYEXE "${VENV_DIR}/bin/python3")
        set(SIX_LOC "${VENV_DIR}/lib/site-packages/six.py")
    endif()
    set(REQUIREMENTS "${CMAKE_SOURCE_DIR}/python/requirements.txt")

    add_custom_command(
        OUTPUT ${PYEXE}
        COMMAND ${BASEPYEXE} -m venv ${VENV_DIR}
        )

    add_custom_command(
        OUTPUT ${SIX_LOC}
        COMMAND ${PYEXE} -m pip install -r ${REQUIREMENTS}
        DEPENDS ${PYEXE}
        )

    add_custom_target(cpp_python_gen DEPENDS ${SIX_LOC})
else()
    set(BASEPYEXE python3)
    set(PYEXE python3)

    add_custom_target(cpp_python_gen)
endif()

