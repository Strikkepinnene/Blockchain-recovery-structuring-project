# PowerShell Script to Organize Documentation for Professional Presentation
# Social Node - Blockchain Recovery Documentation Master

Write-Host "=== SOCIAL NODE BLOCKCHAIN RECOVERY DOCUMENTATION ORGANIZER ===" -ForegroundColor Green
Write-Host "Preparing professional documentation package for external presentation..." -ForegroundColor Yellow

# Define the documentation master folder path
$DocMasterPath = "c:\Users\human\OneDrive\Desktop\Social Node - Blockchain recovery docu MASTER"

# Create main documentation structure
$Folders = @(
    "01_Executive",
    "02_Legal_Compliance", 
    "03_Financial_Advisory",
    "04_Technical",
    "05_Team_Collaboration",
    "06_Presentations",
    "LEGAL_TEMPLATES"
)

# Ensure documentation master folder exists
if (!(Test-Path $DocMasterPath)) {
    New-Item -ItemType Directory -Path $DocMasterPath -Force
    Write-Host "✓ Created documentation master folder" -ForegroundColor Green
}

# Create organized folder structure
foreach ($Folder in $Folders) {
    $FolderPath = Join-Path $DocMasterPath $Folder
    if (!(Test-Path $FolderPath)) {
        New-Item -ItemType Directory -Path $FolderPath -Force
        Write-Host "✓ Created folder: $Folder" -ForegroundColor Green
    }
}

# Define document mappings (source -> destination folder)
$DocumentMappings = @{
    # Executive Materials
    "EXECUTIVE_SUMMARY.md" = "01_Executive"
    "PROJECT_STATUS_SUMMARY.md" = "01_Executive" 
    "STRATEGIC_REVIEW.md" = "01_Executive"
    "PRINTABLE_SUMMARY.md" = "01_Executive"
    
    # Legal & Compliance
    "LEGAL_COMPLIANCE.md" = "02_Legal_Compliance"
    "LEGAL_ACTION_CHECKLIST.md" = "02_Legal_Compliance"
    
    # Financial & Advisory  
    "ECONOMIC_IMPACT_ASSESSMENT.md" = "03_Financial_Advisory"
    "ECONOMIC_POTENTIAL_OVERVIEW.md" = "03_Financial_Advisory"
    "FORVIS_MAZARS_STRATEGY.md" = "03_Financial_Advisory"
    "30_DAY_ACTION_PLAN.md" = "03_Financial_Advisory"
    "CONSULTATION_PREPARATION.md" = "03_Financial_Advisory"
    
    # Technical Documentation
    "DOCUMENTATION.md" = "04_Technical" 
    "SECURITY.md" = "04_Technical"
    "DOCKER_README.md" = "04_Technical"
    "TEAM_ACCESS_GUIDE.md" = "04_Technical"
    
    # Team Collaboration
    "TEAM_WORKFLOW_DELEGATION.md" = "05_Team_Collaboration"
    "PROFESSIONAL_DOCUMENTATION_PACKAGE.md" = "05_Team_Collaboration"
    "TEAM_INVITATION.md" = "05_Team_Collaboration"
    "WORKFLOW_COMPLETION.md" = "05_Team_Collaboration"
    
    # Presentations
    "README.md" = "06_Presentations"
    "PROJECT_DRAFT.md" = "06_Presentations" 
    "VERIFICATION_REPORT.md" = "06_Presentations"
    
    # Documentation Package Index
    "DOCUMENTATION_PACKAGE_INDEX.md" = "."
}

# Copy documents to organized structure
$CurrentPath = Get-Location
Write-Host "`nCopying documents to organized structure..." -ForegroundColor Yellow

foreach ($Document in $DocumentMappings.GetEnumerator()) {
    $SourceFile = Join-Path $CurrentPath $Document.Key
    $DestFolder = if ($Document.Value -eq ".") { $DocMasterPath } else { Join-Path $DocMasterPath $Document.Value }
    $DestFile = Join-Path $DestFolder $Document.Key
    
    if (Test-Path $SourceFile) {
        Copy-Item $SourceFile $DestFile -Force
        Write-Host "✓ Copied: $($Document.Key) -> $($Document.Value)" -ForegroundColor Green
    } else {
        Write-Host "⚠ Missing: $($Document.Key)" -ForegroundColor Yellow
    }
}

# Copy Legal Templates folder
$LegalTemplatesSource = Join-Path $CurrentPath "LEGAL_TEMPLATES"
$LegalTemplatesDest = Join-Path $DocMasterPath "LEGAL_TEMPLATES"

if (Test-Path $LegalTemplatesSource) {
    Copy-Item $LegalTemplatesSource $DocMasterPath -Recurse -Force
    Write-Host "✓ Copied: LEGAL_TEMPLATES folder with all templates" -ForegroundColor Green
} else {
    Write-Host "⚠ Missing: LEGAL_TEMPLATES folder" -ForegroundColor Yellow
}

# Copy the HTML presentation file if it exists on desktop
$HTMLSource = "c:\Users\Tom Ove\Desktop\Blockchain_Recovery_Professional_Framework.html"
$HTMLDest = Join-Path (Join-Path $DocMasterPath "01_Executive") "Blockchain_Recovery_Professional_Framework.html"

if (Test-Path $HTMLSource) {
    Copy-Item $HTMLSource $HTMLDest -Force
    Write-Host "✓ Copied: Professional HTML presentation to Executive folder" -ForegroundColor Green
}

# Create audience-specific README files for each folder
$ReadmeContent = @{
    "01_Executive" = @"
# EXECUTIVE MATERIALS
**For:** C-Level Executives, Board Members, Senior Officials

## Key Documents:
- **EXECUTIVE_SUMMARY.md** - High-level project overview
- **PROJECT_STATUS_SUMMARY.md** - Current readiness status
- **STRATEGIC_REVIEW.md** - Market positioning analysis
- **Blockchain_Recovery_Professional_Framework.html** - Printable presentation

## Recommended Presentation Order:
1. Executive Summary (5 minutes)
2. Project Status Summary (3 minutes)  
3. Strategic Review (10 minutes)
4. Q&A and Discussion (15 minutes)

**Target Audience:** Senior decision makers requiring strategic overview
"@

    "02_Legal_Compliance" = @"
# LEGAL & COMPLIANCE MATERIALS
**For:** Legal Counsel, Regulatory Authorities, Compliance Officers

## Key Documents:
- **LEGAL_COMPLIANCE.md** - Comprehensive regulatory framework
- **LEGAL_ACTION_CHECKLIST.md** - Implementation requirements
- **NDA_BLOCKCHAIN_RECOVERY.md** - Confidentiality template
- **MOU_ADVISORY_COLLABORATION.md** - Partnership framework
- **FORMAL_LETTER_FORVIS_MAZARS.md** - Professional advisory request

## Focus Areas:
- Norwegian regulatory compliance strategy
- Multi-jurisdiction legal coordination
- Risk mitigation and management protocols
- Professional advisory engagement framework

**Target Audience:** Legal professionals and regulatory specialists
"@

    "03_Financial_Advisory" = @"
# FINANCIAL & ADVISORY MATERIALS  
**For:** Financial Institutions, Accounting Firms, Investment Partners

## Key Documents:
- **FORVIS_MAZARS_STRATEGY.md** - Strategic partnership approach
- **30_DAY_ACTION_PLAN.md** - Implementation timeline
- **CONSULTATION_PREPARATION.md** - Professional engagement framework

## Financial Highlights:
- Professional advisory team structure
- Regulatory compliance-first approach
- Risk management and mitigation strategies
- Partnership and collaboration opportunities

**Target Audience:** Financial professionals and advisory partners
"@

    "04_Technical" = @"
# TECHNICAL DOCUMENTATION
**For:** Technical Teams, IT Security, Systems Integration Partners

## Key Documents:
- **DOCUMENTATION.md** - Technical framework overview
- **SECURITY.md** - Security protocols and architecture
- **DOCKER_README.md** - Containerized environment
- **TEAM_ACCESS_GUIDE.md** - Collaboration infrastructure

## Technical Highlights:
- Enterprise-grade security architecture
- Professional collaboration infrastructure
- Scalable and secure operational environment
- Industry best practices implementation

**Target Audience:** Technical professionals and security specialists
"@

    "05_Team_Collaboration" = @"
# TEAM COLLABORATION MATERIALS
**For:** Professional Advisory Partners, Consultant Teams

## Key Documents:
- **TEAM_WORKFLOW_DELEGATION.md** - Team integration framework
- **PROFESSIONAL_DOCUMENTATION_PACKAGE.md** - Complete overview
- **TEAM_INVITATION.md** - Professional engagement invitation
- **WORKFLOW_COMPLETION.md** - Readiness verification

## Collaboration Features:
- Structured professional team integration
- Clear roles and responsibilities framework
- Professional communication protocols
- Quality assurance and validation procedures

**Target Audience:** Professional advisory team members and consultants
"@

    "06_Presentations" = @"
# PRESENTATION MATERIALS
**For:** Meetings, Presentations, Stakeholder Reviews

## Key Documents:
- **README.md** - Project introduction and overview
- **PROJECT_DRAFT.md** - Development summary
- **VERIFICATION_REPORT.md** - System validation summary

## Presentation Focus:
- Project introduction and objectives
- Professional development approach
- System verification and validation
- Stakeholder engagement and benefits

**Target Audience:** General stakeholder presentations and introductions
"@
}

# Create README files for each folder
foreach ($Folder in $ReadmeContent.GetEnumerator()) {
    $ReadmePath = Join-Path (Join-Path $DocMasterPath $Folder.Key) "README.md"
    $Folder.Value | Out-File -FilePath $ReadmePath -Encoding UTF8
    Write-Host "✓ Created README for: $($Folder.Key)" -ForegroundColor Green
}

# Create main documentation package summary
$MainSummary = @"
# SOCIAL NODE - BLOCKCHAIN RECOVERY DOCUMENTATION MASTER
**Professional Documentation Package for External Presentation**

## 📋 PACKAGE CONTENTS

This documentation package contains comprehensive professional materials organized for presentation to:
- Financial institutions and banks
- Legal advisors and regulatory authorities  
- Government officials and regulators
- Potential collaboration partners and advisors

## 🗂️ ORGANIZATION STRUCTURE

- **01_Executive/** - C-level and senior official materials
- **02_Legal_Compliance/** - Legal and regulatory documentation
- **03_Financial_Advisory/** - Financial institution and advisory materials
- **04_Technical/** - Technical architecture and security documentation
- **05_Team_Collaboration/** - Professional team integration materials
- **06_Presentations/** - General presentation and overview materials
- **LEGAL_TEMPLATES/** - Professional agreement templates

## 🎯 USAGE INSTRUCTIONS

1. **Review DOCUMENTATION_PACKAGE_INDEX.md** for complete guidance
2. **Select audience-appropriate materials** from relevant folders
3. **Execute NDA before sharing** any confidential materials
4. **Maintain professional confidentiality** at all times

## 📞 CONTACT INFORMATION

**Project:** Social Node - Blockchain Recovery Framework  
**GitHub:** https://github.com/Strikkepinnene/Blockchain-recovery-structuring-project  
**Status:** Professional presentation ready  
**Classification:** Non-sensitive professional materials

---
**Prepared:** October 15, 2025  
**Version:** 1.0 - Professional Stakeholder Ready
"@

$MainSummaryPath = Join-Path $DocMasterPath "README.md"
$MainSummary | Out-File -FilePath $MainSummaryPath -Encoding UTF8

Write-Host "`n=== DOCUMENTATION PACKAGE ORGANIZATION COMPLETE ===" -ForegroundColor Green
Write-Host "✓ Professional documentation ready at: $DocMasterPath" -ForegroundColor Green
Write-Host "✓ Organized into 6 audience-specific folders" -ForegroundColor Green  
Write-Host "✓ README files created for each category" -ForegroundColor Green
Write-Host "✓ Legal templates included for professional use" -ForegroundColor Green
Write-Host "`n📋 Next Steps:" -ForegroundColor Yellow
Write-Host "1. Review DOCUMENTATION_PACKAGE_INDEX.md for presentation guidance" -ForegroundColor White
Write-Host "2. Select materials appropriate for your audience" -ForegroundColor White
Write-Host "3. Ensure NDA execution before sharing confidential materials" -ForegroundColor White
Write-Host "4. Professional presentation materials ready for stakeholder meetings" -ForegroundColor White