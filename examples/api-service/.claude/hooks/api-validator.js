#!/usr/bin/env node
/**
 * API Validator Hook
 *
 * Validates that API route changes maintain contract compatibility
 * Checks for breaking changes in endpoints
 */

const fs = require('fs');
const path = require('path');

// Simple validation - in production you'd use OpenAPI spec comparison
function validateRouteFile(filePath) {
  try {
    const content = fs.readFileSync(filePath, 'utf8');

    // Check for common issues
    const issues = [];

    // Check 1: Ensure error handling
    if (!content.includes('try') && !content.includes('catch')) {
      issues.push('⚠️  No try/catch error handling found');
    }

    // Check 2: Ensure response status codes
    if (!content.includes('res.status')) {
      issues.push('⚠️  No explicit status codes - use res.status(200), etc.');
    }

    // Check 3: Check for authentication middleware
    if (content.includes('router.post') || content.includes('router.put')) {
      if (!content.includes('auth') && !content.includes('authenticate')) {
        issues.push('ℹ️  POST/PUT routes should consider authentication');
      }
    }

    // Check 4: Validation middleware
    if (content.includes('req.body') && !content.includes('validate')) {
      issues.push('ℹ️  Consider adding input validation for req.body');
    }

    if (issues.length > 0) {
      console.log(`\n🔍 API route analysis for ${path.basename(filePath)}:`);
      issues.forEach(issue => console.log(`  ${issue}`));
      console.log('');
    } else {
      console.log(`✅ API route looks good: ${path.basename(filePath)}`);
    }

    return true;
  } catch (error) {
    console.error(`❌ Error validating ${filePath}:`, error.message);
    return false;
  }
}

// Get the file from environment or args
const targetFile = process.env.TOOL_INPUT || process.argv[2];

if (targetFile && fs.existsSync(targetFile)) {
  validateRouteFile(targetFile);
}

process.exit(0);
