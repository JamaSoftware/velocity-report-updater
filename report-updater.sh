#!/usr/bin/env bash
REPORTS_DIRECTORY="$1" # path to the dir that contains .vm reports to operate on

if [ -z "$REPORTS_DIRECTORY" ]
then
    echo "usage:"
    echo "    $0 REPORTS_DIRECTORY"
    exit 1
fi

echo "This program will operate on files in place!"
echo "Make sure you have backups or are using source control before continuing!"

while true
do
    read -p "continue? y/n" YN
    case $YN in
        [Yy]* ) echo continuing...; break;;
        [Nn]* ) exit;;
        * ) echo "Answer yes or no";;
    esac
done

REPLACE=$(cat <<REPLACEMENT_EXPRS
s/applicationContext.getBean\("aclManager"\)/adminSource/g;
s/applicationContext.getBean\("aclPermissionEntryDao"\)/adminSource/g;
s/applicationContext.getBean\("aclService"\)/adminSource/g;
s/applicationContext.getBean\("attachmentDao"\)/documentSource/g;
s/applicationContext.getBean\("attachmentService"\)/documentSource/g;
s/applicationContext.getBean\("baseLineDao"\)/baselineSource/g;
s/applicationContext.getBean\("baseLineService"\)/baselineSource/g;
s/applicationContext.getBean\("commentDao"\)/commentSource/g;
s/applicationContext.getBean\("contourItemDao"\)/documentSource/g;
s/applicationContext.getBean\("documentDao"\)/documentSource/g;
s/applicationContext.getBean\("documentFieldDao"\)/documentSource/g;
s/applicationContext.getBean\("documentGroupDao"\)/documentSource/g;
s/applicationContext.getBean\("documentNodeDao"\)/documentSource/g;
s/applicationContext.getBean\("documentNodeManager"\)/documentSource/g;
s/applicationContext.getBean\("documentNodeService"\)/documentSource/g;
s/applicationContext.getBean\("documentService"\)/documentSource/g;
s/applicationContext.getBean\("documentTypeDao"\)/documentSource/g;
s/applicationContext.getBean\("documentTypeFieldDao"\)/documentSource/g;
s/applicationContext.getBean\("documentTypeService"\)/documentSource/g;
s/applicationContext.getBean\("document_UrlDao"\)/documentSource/g;
s/applicationContext.getBean\("dwrLicenseService"\)/adminSource/g;
s/applicationContext.getBean\("eventLogDao"\)/eventSource/g;
s/applicationContext.getBean\("filterDao"\)/filterSource/g;
s/applicationContext.getBean\("legacyDocumentNodeManager"\)/documentSource/g;
s/applicationContext.getBean\("lookupDao"\)/documentSource/g;
s/applicationContext.getBean\("lookupTypeDao"\)/documentSource/g;
s/applicationContext.getBean\("projectDao"\)/projectSource/g;
s/applicationContext.getBean\("projectFieldDao"\)/projectSource/g;
s/applicationContext.getBean\("relationshipDao"\)/documentSource/g;
s/applicationContext.getBean\("relationshipTypeDao"\)/documentSource/g;
s/applicationContext.getBean\("releaseDao"\)/releaseSource/g;
s/applicationContext.getBean\("reviewDao"\)/reviewSource/g;
s/applicationContext.getBean\("reviewProgressDTO"\)/reviewSource/g;
s/applicationContext.getBean\("revisionDao"\)/reviewSource/g;
s/applicationContext.getBean\("revisionInfoDao"\)/reviewSource/g;
s/applicationContext.getBean\("revisionItemDao"\)/reviewSource/g;
s/applicationContext.getBean\("revisionRelationshipRetriever"\)/documentSource/g;
s/applicationContext.getBean\("revisionUserService"\)/reviewSource/g;
s/applicationContext.getBean\("roleDao"\)/userSource/g;
s/applicationContext.getBean\("signatureDao"\)/reviewSource/g;
s/applicationContext.getBean\("smartFilterDao"\)/filterSource/g;
s/applicationContext.getBean\("syncStatusService"\)/documentSource/g;
s/applicationContext.getBean\("tagDao"\)/documentSource/g;
s/applicationContext.getBean\("testCycleDao"\)/testSource/g;
s/applicationContext.getBean\("testPlanDao"\)/testSource/g;
s/applicationContext.getBean\("testRunDao"\)/testSource/g;
s/applicationContext.getBean\("testRunSetDao"\)/testSource/g;
s/applicationContext.getBean\("testSetDao"\)/testSource/g;
s/applicationContext.getBean\("userDao"\)/userSource/g;
s/applicationContext.getBean\("userLogEntryDao"\)/userSource/g;
s/applicationContext.getBean\("userService"\)/userSource/g;
s/applicationContext.getBean\("versionDao"\)/documentSource/g;
s/velocityServiceWrapper.getItem/documentSource.getItem/g;
s/velocityServiceWrapper.getRelationships/documentSource.getRelationships/g;
REPLACEMENT_EXPRS
)

find "$REPORTS_DIRECTORY" -iname '*.vm' -print0 | xargs -t -0 perl -p -i -e "$REPLACE"
