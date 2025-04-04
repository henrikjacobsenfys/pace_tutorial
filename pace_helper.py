import requests
import re

BASE_URL = "https://raw.githubusercontent.com/pace-neutrons/Horace/master/"
SEARCH_PATHS = [
    "horace_core",
    "horace_core/general",
    "horace_core/sqw",
    "horace_core/sqw/coord_transform",
    "horace_core/sqw/file_io",
    "horace_core/sqw/PixelData",
    "horace_core/sqw/visualization",
    "horace_core/sqw/page_operations",
    "horace_core/sqw_models",
    "horace_core/utilities",
    "horace_core/utilities/validators",
    "horace_core/symop",
]

def _try_download_function(function_name):
    for path in SEARCH_PATHS:
        url = f"{BASE_URL}{path}/{function_name}.m"
        response = requests.get(url)
        if response.status_code == 200:
            return response.text, f"{path}/{function_name}.m"
    raise FileNotFoundError(f"Function '{function_name}' not found in known Horace folders.")

def _extract_help_text(matlab_code):
    lines = matlab_code.splitlines()
    help_lines = []
    in_function_block = False
    in_help_block = False

    for line in lines:
        stripped = line.strip()
        if not in_function_block and re.match(r'^function\b', stripped):
            in_function_block = True
            continue

        if in_function_block:
            if stripped.startswith('%'):
                in_help_block = True
                help_lines.append(stripped.lstrip('%').strip())
            elif stripped == "" and in_help_block:
                help_lines.append("")
            elif in_help_block:
                break

    return "\n".join(help_lines).strip()

def pace_helper(function_name):
    """
    Retrieve help for a MATLAB function from the Horace GitHub repository.

    Example:
        import pace_helper
        pace_helper.pace_helper('spaghetti_plot')
    """
    if not function_name or not isinstance(function_name, str):
        print("Please provide a valid MATLAB function name as a string.")
        return

    try:
        code, path = _try_download_function(function_name)
        help_text = _extract_help_text(code)
        print(f"Help for `{function_name}` (from {path}):\n")
        print(help_text if help_text else "(No help text found.)")

    except FileNotFoundError as e:
        print(e)
    except Exception as e:
        print(f"Unexpected error: {e}")

import sys
