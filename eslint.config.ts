import eslintConfigPrettier from "eslint-config-prettier/flat";
import { defineConfig, globalIgnores } from "eslint/config";

const eslintConfig = defineConfig([
  eslintConfigPrettier,
  // Override default ignores of eslint-config-next.
  globalIgnores([
    // Default ignores of eslint-config-next:
    "out/**",
    "build/**",
    "dist/**",
    ".github/**",
    "eslint.config.ts",
    ".prettierignore",
    "lefthook.yaml",
    ".agents/**",
    "skills-lock.json",
  ]),
]);

export default eslintConfig;
